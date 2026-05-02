{
  config,
  lib,
  ...
}: {
  options.modules.psql.enable = lib.mkEnableOption "psql";

  config = lib.mkIf config.modules.psql.enable {
    home.sessionVariables = {
      PSQL_HISTORY = "${config.xdg.stateHome}/psql/history";
      PSQLRC = "${config.xdg.configHome}/psql/psqlrc";
    };

    xdg.configFile."psql/psqlrc".source = ./psqlrc;
  };
}
