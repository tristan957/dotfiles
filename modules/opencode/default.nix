{
  config,
  lib,
  ...
}: {
  options.modules.opencode.enable = lib.mkEnableOption "opencode";

  config = lib.mkIf config.modules.opencode.enable {
    programs.opencode = {
      enable = true;
      skills = ../../skills;
      themes = ./themes;
      tui.theme = "one-dark-vivid";
    };
  };
}
