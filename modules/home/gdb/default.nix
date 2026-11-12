{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.gdb;
in {
  options.dotfiles.gdb.package = lib.mkPackageOption pkgs "gdb" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    home.sessionVariables = {
      GDBHISTFILE = "${config.xdg.stateHome}/gdb/history";
    };

    xdg.configFile."gdb/gdbinit".source = ./gdbinit;
  };
}
