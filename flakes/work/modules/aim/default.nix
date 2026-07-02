{config, ...}: {
  programs.opencode.settings.skills.paths = ["${config.home.homeDirectory}/.aim/skills"];

  programs.toolbox = {
    tools.aim.enable = true;

    aim = {
      enable = true;
      mcpServers = {
        builder-mcp = {};
        m365-mcp = {};
      };
    };
  };
}
