{
  dotfilesPackages,
  pkgs,
  inputs,
  ...
}: let
  json = pkgs.formats.json {};
  mcp = import ../../lib/mcp.nix {
    inherit (inputs.dotfiles.lib.mcp) mkLocal;
  };
in {
  programs.toolbox.kiro.cli.enable = true;

  home.file = {
    ".kiro/skills".source = "${dotfilesPackages.skills}/skills";
    ".kiro/settings/mcp.json".source = json.generate "mcp.json" {
      mcpServers = inputs.dotfiles.lib.mcp.kiro.generate [
        inputs.dotfiles.lib.mcp.servers._1password
        mcp.servers.builder-mcp
        mcp.servers.creds-agent
      ];
    };
  };
}
