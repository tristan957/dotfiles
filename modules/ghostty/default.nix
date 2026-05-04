{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.ghostty.enable = lib.mkEnableOption "ghostty";

  config = lib.mkIf config.modules.ghostty.enable {
    xdg.configFile = {
      "ghostty/config.ghostty".source = ./config.ghostty;
      "ghostty/themes".source = ./themes;
    };

    home.file = lib.mkIf pkgs.stdenv.isDarwin {
      "Library/Application Support/com.mitchellh.ghostty/config.ghostty" = {
        source = ./config.darwin.ghostty;
        force = true;
      };
    };
  };
}
