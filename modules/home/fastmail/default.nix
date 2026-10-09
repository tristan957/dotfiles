{...}: {
  config = {
    programs.mcp = {
      enable = true;
      servers.fastmail.url = "https://api.fastmail.com/mcp";
    };
  };
}
