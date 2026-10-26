{config, ...}: {
  programs.opencode.settings.skills = ["${config.home.homeDirectory}/.aim/skills"];

  programs.mcp = {
    servers.creds-agent = {
      command = "aim";
      args = ["mcp" "start-server" "local-creds-agent-mcp"];
    };
  };

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
