{
  config,
  lib,
  ...
}: {
  options.modules.opencode.enable = lib.mkEnableOption "opencode";

  config = lib.mkIf config.modules.opencode.enable {
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
      };

      skills = ../../skills;
      themes = ./themes;
      tui.theme = "one-dark-vivid";
    };
  };
}
