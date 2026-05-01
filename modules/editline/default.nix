{config, ...}: {
  home.sessionVariables = {
    EDITRC = "${config.xdg.configHome}/editline/editrc";
  };

  xdg.configFile."editline/editrc".source = ./editrc;
}
