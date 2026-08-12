{
  dotfilesPackages,
  mcp,
  pkgs,
  ...
}: let
  json = pkgs.formats.json {};
in {
  programs.toolbox.kiro.cli.enable = true;

  home.file = {
    ".kiro/skills".source = "${dotfilesPackages.skills}/skills";
    ".kiro/settings/mcp.json".source = json.generate "mcp.json" {
      mcpServers = mcp.kiro.generate [
        mcp.servers._1password
        mcp.servers.builder-mcp
        mcp.servers.creds-agent
      ];
    };
  };
}
