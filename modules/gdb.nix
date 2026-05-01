{config, ...}: {
  home.sessionVariables = {
    GDBHISTFILE = "${config.xdg.stateHome}/gdb/history";
  };

  xdg.configFile."gdb/gdbinit".source = ../gdb/.config/gdb/gdbinit;
}
