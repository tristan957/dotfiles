{
  config,
  lib,
  ...
}: {
  options.modules.gdb.enable = lib.mkEnableOption "gdb";

  config = lib.mkIf config.modules.gdb.enable {
    home.sessionVariables = {
      GDBHISTFILE = "${config.xdg.stateHome}/gdb/history";
    };

    xdg.configFile."gdb/gdbinit".source = ./gdbinit;
  };
}
