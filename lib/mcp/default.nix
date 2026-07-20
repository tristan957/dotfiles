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

  # A locally spawned MCP server run as a subprocess
  mkLocal = args:
    (mkChecked
      {
        name = strOption;
        command = strOption;
        env = envOption;
      }
      args)
    // {kind = "local";};

  # A remote MCP server reached over HTTP
  mkRemote = args:
    (mkChecked
      {
        name = strOption;
        url = strOption;
        oauth = lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = {};
        };
      }
      args)
    // {kind = "remote";};
in {
  inherit mkLocal mkRemote;

  # Server definitions shared across configs (currently just the personal
  # opencode config, but nothing ties a server to a particular consumer).
  servers = {
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
            enabled = false;
            type = server.kind;
          }
          // (
            if server.kind == "local"
            then {
              command = [server.command];
              env = server.env;
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
          then {
            type = "local";
            command = server.command;
            args = [];
            env = server.env;
          }
          else throw "mcp.kiro.generate: unknown server kind `${server.kind}`";
      })
      servers);
}
