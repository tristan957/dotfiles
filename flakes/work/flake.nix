{
  description = "Work-specific Home Manager extensions";

  inputs = {
    dotfiles.url = "path:../..";
    amzn = {
      url = "git+ssh://git.amazon.com/pkg/AmznNix-Community";
      inputs.nixpkgs.follows = "dotfiles/nixpkgs";
      inputs.home-manager.follows = "dotfiles/home-manager";
    };
  };

  outputs = {
    dotfiles,
    amzn,
    ...
  }: {
    homeConfigurations =
      builtins.mapAttrs (
        _: config:
          config.extendModules {
            modules = [
              amzn.homeModules.default
              ({
                pkgs,
                lib,
                ...
              }: let
                json = pkgs.formats.json {};
              in {
                home.packages = [
                  amzn.packages.${pkgs.stdenv.hostPlatform.system}.mcurl
                ];

                home.activation.kiroMcpConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
                  install -Dm644 ${json.generate "mcp.json" {
                    mcpServers = {
                      builder-mcp = {
                        command = "builder-mcp";
                        args = [];
                        env = {
                          TOOL_PERSONALIZATION_ENABLED = "true";
                          TOOL_PERSONALIZATION_MIN_EXECUTIONS = 0;
                          TOOL_PERSONALIZATION_TRAINING_DAYS = 0;
                          TOOL_PERSONALIZATION_ROLLOUT_PERCENTAGE = 100;
                        };
                      };
                      m365-mcp = {
                        command = "grasp-mcp";
                        args = [];
                      };
                    };
                  }} "$HOME/.kiro/settings/mcp.json"
                '';

                services.midway.aea.cookie-refresh.enable = true;

                programs.toolbox = {
                  enable = true;
                  registries = {
                    grasp-tools.uri = "s3://buildertoolbox-registry-grasp-tools-us-west-2/tools.json";
                    isengard-cli.uri = "s3://buildertoolbox-registry-isengard-cli-us-west-2/tools.json";
                  };
                  tools = {
                    ada.enable = true;
                    aim.enable = true;
                    axe.enable = true;
                    barium.enable = true;
                    brazilcli.enable = true;
                    cr.enable = true;
                    isengard-cli.enable = true;
                  };
                  ada = {
                    enable = true;
                    defaults = {
                      Provider = "isengard";
                      Region = "us-west-2";
                    };
                    profiles.dbltap = {
                      Account = "534344665149";
                    };
                  };
                  aim = {
                    enable = true;
                    mcpServers = {
                      builder-mcp = {};
                      m365-mcp = {};
                    };
                  };
                  kiro.cli.enable = true;
                };
              })
            ];
          }
      )
      dotfiles.homeConfigurations;
  };
}
