{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.just;
in {
  options.dotfiles.just.package = lib.mkPackageOption pkgs "just" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    xdg.configFile."just/justfile".source = ./justfile;
  };
}
