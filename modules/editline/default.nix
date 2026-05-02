{
  config,
  lib,
  ...
}: {
  options.modules.editline.enable = lib.mkEnableOption "editline";

  config = lib.mkIf config.modules.editline.enable {
    home.sessionVariables = {
      EDITRC = "${config.xdg.configHome}/editline/editrc";
    };

    xdg.configFile."editline/editrc".source = ./editrc;
  };
}
