{
  config,
  lib,
  ...
}: {
  options.modules.readline.enable = lib.mkEnableOption "readline";

  config = lib.mkIf config.modules.readline.enable {
    home.sessionVariables = {
      INPUTRC = "${config.xdg.configHome}/readline/inputrc";
    };

    xdg.configFile."readline/inputrc".source = ./inputrc;
  };
}
