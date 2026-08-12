# MCP server helpers, exposed under the flake's `lib.mcp` namespace:
# type-checked constructors for generic server records, plus per-tool generators
# that turn a list of those records into each tool's native config shape.
#
{lib}: let
  # Builds and validates `config` against `options` by treating them as a
  # single, self-contained module and asking `evalModules` to evaluate it.
  mkChecked = options: config:
    (lib.evalModules {
      modules = [{inherit options config;}];
    })
    .config;

  strOption = lib.mkOption {type = lib.types.str;};
  envOption = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {};
  };
  argsOption = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
  };
  # Optional override for whether a server is loaded at startup. `null` means
  # "defer to the consuming tool's own default", which differs per tool:
  # OpenCode opts servers out, Kiro opts them in. Each generator renders this
  # in its tool's own spelling (OpenCode `enabled`, Kiro `disabled`).
  enabledOption = lib.mkOption {
    type = lib.types.nullOr lib.types.bool;
    default = null;
  };

  # A locally spawned MCP server run as a subprocess
  mkLocal = args:
    (mkChecked
      {
        name = strOption;
        command = strOption;
        args = argsOption;
        env = envOption;
        enabled = enabledOption;
      }
      args)
    // {kind = "local";};

  # A remote MCP server reached over HTTP
  mkRemote = args:
    (mkChecked
      {
        name = strOption;
        url = strOption;
        enabled = enabledOption;
        oauth = lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = {};
        };
      }
      args)
    // {kind = "remote";};
in {
  inherit mkLocal mkRemote;

  servers = {
    _1password = mkLocal {
      name = "1password";
      command = "1password-mcp";
    };

    fastmail = mkRemote {
      name = "fastmail";
      url = "https://api.fastmail.com/mcp";
    };
  };

  # Turns a list of generic server records (from `mkLocal`/`mkRemote`) into
  # OpenCode's native `mcp` settings value, keyed by server name.
  opencode.generate = servers:
    lib.listToAttrs (map (server: {
        name = server.name;
        value =
          {
            # OpenCode servers stay opt-in unless a definition says otherwise.
            enabled =
              if server.enabled == null
              then false
              else server.enabled;
            type = server.kind;
          }
          // (
            if server.kind == "local"
            then {
              command = [server.command] ++ server.args;
              # OpenCode's McpLocalConfig names this `environment`, and its
              # schema sets `additionalProperties: false`, so `env` is rejected.
              environment = server.env;
            }
            else if server.kind == "remote"
            then {inherit (server) url oauth;}
            else throw "mcp.opencode.generate: unknown server kind `${server.kind}`"
          );
      })
      servers);

  # Turns a list of generic server records into Kiro's native `mcpServers`
  # value, keyed by server name.
  kiro.generate = servers:
    lib.listToAttrs (map (server: {
        name = server.name;
        value =
          if server.kind == "local"
          then
            {
              type = "local";
              command = server.command;
              args = server.args;
              env = server.env;
            }
            # Kiro loads servers by default, so only emit the key when a
            # definition overrides it (see `kiro-cli mcp add --disabled`).
            // lib.optionalAttrs (server.enabled != null) {
              disabled = !server.enabled;
            }
          else throw "mcp.kiro.generate: unknown server kind `${server.kind}`";
      })
      servers);
}
