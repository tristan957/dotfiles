{config, ...}: {
  config = {
    home.file = {
      ".local/bin/c2f" = config.lib.file.mkExecutable ./c2f;
      ".local/bin/chcompdb" = config.lib.file.mkExecutable ./chcompdb;
      ".local/bin/dbgwait" = config.lib.file.mkExecutable ./dbgwait;
      ".local/bin/f2c" = config.lib.file.mkExecutable ./f2c;
      ".local/bin/pg_lsn" = config.lib.file.mkExecutable ./pg_lsn;
      ".local/bin/pgsql-hacker" = config.lib.file.mkExecutable ./pgsql-hacker;
      ".local/bin/substr" = config.lib.file.mkExecutable ./substr;
      ".local/bin/universal-copy" = config.lib.file.mkExecutable ./universal-copy;
      ".local/bin/xdp-file-chooser" = config.lib.file.mkExecutable ./xdp-file-chooser;
      ".local/bin/yaml2json" = config.lib.file.mkExecutable ./yaml2json;
    };
  };
}
