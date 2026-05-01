{...}: {
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.file = {
    ".local/bin/c2f" = {
      source = ../programs/.local/bin/c2f;
      executable = true;
    };
    ".local/bin/chcompdb" = {
      source = ../programs/.local/bin/chcompdb;
      executable = true;
    };
    ".local/bin/dbgwait" = {
      source = ../programs/.local/bin/dbgwait;
      executable = true;
    };
    ".local/bin/f2c" = {
      source = ../programs/.local/bin/f2c;
      executable = true;
    };
    ".local/bin/pg_lsn" = {
      source = ../programs/.local/bin/pg_lsn;
      executable = true;
    };
    ".local/bin/pgsql-hacker" = {
      source = ../programs/.local/bin/pgsql-hacker;
      executable = true;
    };
    ".local/bin/substr" = {
      source = ../programs/.local/bin/substr;
      executable = true;
    };
    ".local/bin/universal-copy" = {
      source = ../programs/.local/bin/universal-copy;
      executable = true;
    };
    ".local/bin/xdp-file-chooser" = {
      source = ../programs/.local/bin/xdp-file-chooser;
      executable = true;
    };
    ".local/bin/yaml2json" = {
      source = ../programs/.local/bin/yaml2json;
      executable = true;
    };
  };
}
