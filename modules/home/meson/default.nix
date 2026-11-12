{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.meson;
in {
  options.dotfiles.meson.package = lib.mkPackageOption pkgs "meson" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    xdg.dataFile."meson/cross/mingw64.ini".source = ./mingw64.ini;
  };
}
