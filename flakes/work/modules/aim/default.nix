{config, ...}: {
  programs.opencode.settings.skills.paths = ["${config.home.homeDirectory}/.aim/skills"];

  programs.toolbox = {
    aim = {
      enable = true;
      mcpServers = {
        builder-mcp = {};
        m365-mcp = {};
      };
    };
  };
}
