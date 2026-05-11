{
  description = "Work-specific Home Manager extensions";

  inputs = {
    dotfiles.url = "path:../..";
    amzn-nix-community = {
      url = "git+ssh://git.amazon.com/pkg/AmznNix-Community";
      inputs.nixpkgs.follows = "dotfiles/nixpkgs";
      inputs.home-manager.follows = "dotfiles/home-manager";
    };
  };

  outputs = {
    dotfiles,
    amzn-nix-community,
    ...
  }: {
    homeConfigurations =
      builtins.mapAttrs (
        _: config:
          config.extendModules {
            modules = [
              amzn-nix-community.homeModules.default
              ({pkgs, ...}: let
                json = pkgs.formats.json {};
              in {
                home.packages = [
                  amzn-nix-community.packages.${pkgs.stdenv.hostPlatform.system}.mcurl
                ];

                home.file.".kiro/settings/mcp.json".source = json.generate "mcp.json" {
                  mcpServers = {
                    builder-mcp = {
                      command = "builder-mcp";
                      args = ["--include-tools=ReadInternalWebsites,InternalCodeSearch,TicketingReadActions,InternalSearch,SkillsTool"];
                    };
                    m365-mcp = {
                      command = "grasp-mcp";
                      args = [];
                    };
                  };
                };

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
                  kiro.cli.enable = true;
                  aim = {
                    enable = true;
                    mcpServers = {
                      builder-mcp = {};
                      m365-mcp = {};
                    };
                  };
                };
              })
            ];
          }
      )
      dotfiles.homeConfigurations;
  };
}
