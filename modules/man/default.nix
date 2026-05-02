{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.man.enable = lib.mkEnableOption "man";

  config = lib.mkIf config.modules.man.enable {
    programs.man.enable = !pkgs.stdenv.isDarwin;

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
