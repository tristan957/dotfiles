{config, ...}: {
  config = {
    home.file = {
      "${config.xdg.binHome}/c2f" = config.lib.file.mkExecutable ./c2f;
      "${config.xdg.binHome}/chcompdb" = config.lib.file.mkExecutable ./chcompdb;
      "${config.xdg.binHome}/dbgwait" = config.lib.file.mkExecutable ./dbgwait;
      "${config.xdg.binHome}/f2c" = config.lib.file.mkExecutable ./f2c;
      "${config.xdg.binHome}/pg_lsn" = config.lib.file.mkExecutable ./pg_lsn;
      "${config.xdg.binHome}/pgsql-hacker" = config.lib.file.mkExecutable ./pgsql-hacker;
      "${config.xdg.binHome}/substr" = config.lib.file.mkExecutable ./substr;
      "${config.xdg.binHome}/universal-copy" = config.lib.file.mkExecutable ./universal-copy;
      "${config.xdg.binHome}/xdp-file-chooser" = config.lib.file.mkExecutable ./xdp-file-chooser;
      "${config.xdg.binHome}/yaml2json" = config.lib.file.mkExecutable ./yaml2json;
    };
  };
}
