{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile = {
    "ghostty/config.ghostty".source = ../ghostty/.config/ghostty/config.ghostty;
    "ghostty/themes".source = ../ghostty/.config/ghostty/themes;
  };

  home.file = lib.mkIf pkgs.stdenv.isDarwin {
    "Library/Application Support/com.mitchellh.ghostty/config.ghostty".source =
      ../ghostty/config.darwin.ghostty;
  };
}
