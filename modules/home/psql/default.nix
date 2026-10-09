{config, ...}: {
  config = {
    home.sessionVariables = {
      PSQL_HISTORY = "${config.xdg.stateHome}/psql/history";
      PSQLRC = "${config.xdg.configHome}/psql/psqlrc";
    };

    home.activation.createPsqlStateDir =
      config.lib.activation.mkDir "${config.xdg.stateHome}/psql";

    xdg.configFile."psql/psqlrc".source = ./psqlrc;
  };
}
