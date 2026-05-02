{
  config,
  lib,
  ...
}: {
  options.modules.programs.enable = lib.mkEnableOption "programs";

  config = lib.mkIf config.modules.programs.enable {
    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    home.file = {
      ".local/bin/c2f" = {
        source = ./c2f;
        executable = true;
      };
      ".local/bin/chcompdb" = {
        source = ./chcompdb;
        executable = true;
      };
      ".local/bin/dbgwait" = {
        source = ./dbgwait;
        executable = true;
      };
      ".local/bin/f2c" = {
        source = ./f2c;
        executable = true;
      };
      ".local/bin/pg_lsn" = {
        source = ./pg_lsn;
        executable = true;
      };
      ".local/bin/pgsql-hacker" = {
        source = ./pgsql-hacker;
        executable = true;
      };
      ".local/bin/substr" = {
        source = ./substr;
        executable = true;
      };
      ".local/bin/universal-copy" = {
        source = ./universal-copy;
        executable = true;
      };
      ".local/bin/xdp-file-chooser" = {
        source = ./xdp-file-chooser;
        executable = true;
      };
      ".local/bin/yaml2json" = {
        source = ./yaml2json;
        executable = true;
      };
    };
  };
}
