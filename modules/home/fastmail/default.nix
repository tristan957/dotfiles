{...}: {
  config = {
    programs.mcp = {
      servers.fastmail.url = "https://api.fastmail.com/mcp";
    };
  };
}
