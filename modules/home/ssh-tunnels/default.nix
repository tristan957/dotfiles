{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;

  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  tunnels = lib.filterAttrs (_: tunnel: tunnel.enable) config.services.ssh-tunnels;

  remoteTarget = tunnel:
    if tunnel.remoteSocket != null
    then tunnel.remoteSocket
    else "${tunnel.remoteHost}:${toString tunnel.remotePort}";

  sshArgs = tunnel:
    ["-N"]
    ++ lib.concatMap (option: ["-o" option]) tunnel.extraOptions
    ++ [
      "-L"
      "${tunnel.localAddress}:${toString tunnel.localPort}:${remoteTarget tunnel}"
      tunnel.host
    ];

  serviceName = name: "ssh-tunnel-${name}";
in {
  options.services.ssh-tunnels = mkOption {
    default = {};
    description = ''
      Persistent `ssh -L` port forwards, run as a launchd agent on macOS and a
      systemd user service on Linux.
    '';
    example = lib.literalExpression ''
      {
        rex-dev = {
          host = "dev.example.com";
          localPort = 17297;
          remoteSocket = "/run/user/1000/rex/server.sock";
        };
        db = {
          host = "dev.example.com";
          localPort = 15432;
          remotePort = 5432;
        };
      }
    '';
    type = types.attrsOf (types.submodule ({name, ...}: {
      options = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Whether to run the tunnel `${name}`.";
        };

        host = mkOption {
          type = types.str;
          example = "dev.example.com";
          description = "The ssh destination, as accepted by `ssh(1)`: a host name, a `~/.ssh/config` alias or `user@host`.";
        };

        localAddress = mkOption {
          type = types.str;
          default = "127.0.0.1";
          description = "The local address to listen on.";
        };

        localPort = mkOption {
          type = types.port;
          description = "The local port to listen on.";
        };

        remoteSocket = mkOption {
          type = types.nullOr types.str;
          default = null;
          example = "/run/user/1000/rex/server.sock";
          description = ''
            Absolute path of a Unix socket on the remote host to forward to.
            Set either this or `remotePort`.
          '';
        };

        remoteHost = mkOption {
          type = types.str;
          default = "localhost";
          example = "db.internal";
          description = ''
            The host to forward to, resolved on the remote host. Write an IPv6
            address in brackets. Only used with `remotePort`.
          '';
        };

        remotePort = mkOption {
          type = types.nullOr types.port;
          default = null;
          description = ''
            The TCP port to forward to on `remoteHost`. Set either this or
            `remoteSocket`.
          '';
        };

        command = mkOption {
          type = types.str;
          default = "/usr/bin/ssh";
          defaultText = lib.literalExpression ''
            /usr/bin/ssh
          '';
          description = ''
            The ssh client.
          '';
        };

        extraOptions = mkOption {
          type = types.listOf types.str;
          default = [
            "BatchMode=yes"
            "ExitOnForwardFailure=yes"
            "ServerAliveInterval=30"
            "ServerAliveCountMax=3"
          ];
          description = ''
            `ssh -o` options. The default makes ssh fail instead of prompting,
            exit when it cannot bind the port, and notice a dead connection.
            Setting this replaces the defaults.
          '';
        };

        logFile = mkOption {
          type = types.nullOr types.str;
          default = null;
          example = "/Users/me/.local/state/ssh-tunnel-example.log";
          description = ''
            File to append ssh's stderr to on macOS. launchd does not rotate
            it, so it grows without limit. When null, the output is discarded.
            Unused on Linux, where the journal captures the output.
          '';
        };

        restartSeconds = mkOption {
          type = types.ints.positive;
          default = 30;
          description = ''
            Minimum seconds between restarts. ssh exits at once when
            authentication fails, for instance with an expired certificate, and
            this keeps the retries from becoming a tight loop.
          '';
        };
      };
    }));
  };

  config = lib.mkMerge [
    {
      assertions =
        lib.mapAttrsToList (name: tunnel: {
          assertion = (tunnel.remoteSocket != null) != (tunnel.remotePort != null);
          message = "services.ssh-tunnels.${name}: set exactly one of remoteSocket and remotePort.";
        })
        tunnels;
    }

    (lib.mkIf (isDarwin && tunnels != {}) {
      launchd.agents = lib.mapAttrs' (name: tunnel:
        lib.nameValuePair (serviceName name) {
          enable = true;
          config =
            {
              ProgramArguments = [tunnel.command] ++ sshArgs tunnel;
              RunAtLoad = true;
              KeepAlive = true;
              ThrottleInterval = tunnel.restartSeconds;
            }
            // lib.optionalAttrs (tunnel.logFile != null) {
              StandardErrorPath = tunnel.logFile;
            };
        })
      tunnels;
    })

    (lib.mkIf (!isDarwin && tunnels != {}) {
      systemd.user.services = lib.mapAttrs' (name: tunnel:
        lib.nameValuePair (serviceName name) {
          Unit = {
            Description = "SSH tunnel ${name}: ${tunnel.localAddress}:${toString tunnel.localPort} to ${tunnel.host}";
            After = ["network-online.target"];
            Wants = ["network-online.target"];
          };
          Service = {
            ExecStart = lib.escapeShellArgs ([tunnel.command] ++ sshArgs tunnel);
            Restart = "always";
            RestartSec = tunnel.restartSeconds;
          };
          Install.WantedBy = ["default.target"];
        })
      tunnels;
    })
  ];
}
