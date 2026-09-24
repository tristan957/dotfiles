{...}: {
  config = {
    programs.mcp = {
      enable = true;
      servers.vercel.url = "https://mcp.vercel.com";
    };
  };
}
