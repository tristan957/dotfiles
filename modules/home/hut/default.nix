{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.hut;
in {
  options.dotfiles.hut.package = lib.mkPackageOption pkgs "hut" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    xdg.configFile."hut/config".source = ./config;
  };
}
