{
  config,
  lib,
  ...
}: {
  options.modules.meson.enable = lib.mkEnableOption "meson";

  config = lib.mkIf config.modules.meson.enable {
    xdg.dataFile."meson/cross/mingw64.ini".source = ./mingw64.ini;
  };
}
