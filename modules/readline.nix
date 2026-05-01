{config, ...}: {
  home.sessionVariables = {
    INPUTRC = "${config.xdg.configHome}/readline/inputrc";
  };

  xdg.configFile."readline/inputrc".source = ../readline/.config/readline/inputrc;
}
