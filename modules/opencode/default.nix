{
  config,
  pkgs,
  ...
}: {
  config = {
    programs.opencode = {
      enable = true;

      settings = {
        mcp = {
          fastmail = {
            enabled = false;
            type = "remote";
            url = "https://api.fastmail.com/mcp";
            oauth = {};
          };
        };
        skills = {
          paths = [
            "${config.home.homeDirectory}/dotfiles/skills"
            "${pkgs.hunk}/skills"
          ];
        };
      };

      tui.theme = "system";
    };
  };
}
