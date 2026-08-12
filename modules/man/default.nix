{
  lib,
  pkgs,
  ...
}: {
  config = {
    programs.man = {
      enable = true;

      # macOS ships its own man, and man-db's mandb/apropos would shadow it.
      # Keep the module enabled so home.extraOutputsToInstall still pulls in
      # the man output of every package.
      package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin null;

      # The fish module turns this on by default to back up `apropos`
      # completion, but generating caches needs man-db, which darwin lacks.
      generateCaches = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin false;
    };

    home.sessionVariables = {
      MANPAGER = "nvim +Man!";
    };

    systemd.user.services."mandb" = {
      Unit.Description = "Regenerate $XDG_DATA_HOME/man man page database";
      Service = {
        Type = "oneshot";
        ExecStart = ''mandb "''${XDG_DATA_HOME}/man"'';
      };
    };

    systemd.user.paths."mandb" = {
      Unit.Description = "Watch for changes in $XDG_DATA_HOME/man";
      Path = {
        MakeDirectory = true;
        PathChanged = "%h/.local/share/man";
      };
      Install.WantedBy = ["paths.target"];
    };
  };
}
