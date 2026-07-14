{
  config,
  lib,
  ...
}: {
  config = {
    home.sessionVariables = {
      PSQL_HISTORY = "${config.xdg.stateHome}/psql/history";
      PSQLRC = "${config.xdg.configHome}/psql/psqlrc";
    };

    home.activation.createPsqlStateDir =
      lib.hm.dag.entryAfter ["writeBoundary"]
      # bash
      ''
        mkdir -p "${config.xdg.stateHome}/psql"
      '';

    xdg.configFile."psql/psqlrc".source = ./psqlrc;
  };
}
