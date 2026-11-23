{lib, ...}: {
  config = {
    programs.gh = {
      enable = lib.mkDefault true;
      gitCredentialHelper.enable = false;
    };

    programs.mcp = {
      servers.github.url = "https://api.githubcopilot.com/mcp/";
    };
  };
}
