{config, ...}: {
  home.sessionVariables = {
    PSQL_HISTORY = "${config.xdg.stateHome}/psql/history";
    PSQLRC = "${config.xdg.configHome}/psql/psqlrc";
  };

  xdg.configFile."psql/psqlrc".source = ./psqlrc;
}
