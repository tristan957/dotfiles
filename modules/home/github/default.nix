{lib, ...}: {
  config = {
    programs.gh = {
      enable = lib.mkDefault true;
      gitCredentialHelper.enable = false;
      settings = {
        "color_labels" = "enabled";
      };
    };

    programs.mcp = {
      servers.github.url = "https://api.githubcopilot.com/mcp/";
    };
  };
}
