{config, ...}: {
  home.sessionVariables = {
    PSQL_HISTORY = "${config.xdg.stateHome}/psql/history";
    PSQLRC = "${config.xdg.configHome}/psql/psqlrc";
  };

  xdg.configFile."psql/psqlrc".source = ../postgresql/.config/postgresql/psqlrc;

  home.file.".local/bin/pg_lsn" = {
    source = ../postgresql/.local/bin/pg_lsn;
    executable = true;
  };
}
