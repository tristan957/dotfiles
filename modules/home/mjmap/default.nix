{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.mjmap;
in {
  options.dotfiles.mjmap.package = lib.mkPackageOption pkgs "mjmap" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    xdg.configFile."mjmap/config.scfg".source = ./config.scfg;
  };
}
