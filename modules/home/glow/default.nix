{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.glow;
in {
  options.dotfiles.glow.package = lib.mkPackageOption pkgs "glow" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    xdg.configFile."glow/glow.yml".source = ./glow.yml;
  };
}
