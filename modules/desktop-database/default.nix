{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.desktop-database.enable = lib.mkEnableOption "desktop-database";

  config = lib.mkIf (config.modules.desktop-database.enable && pkgs.stdenv.isLinux) {
    systemd.user.services."desktop-database" = {
      Unit.Description = "Update $XDG_DATA_HOME/applications/ desktop database";
      Service = {
        Type = "oneshot";
        ExecStart = ''update-desktop-database "''${XDG_DATA_HOME}/applications"'';
      };
    };

    systemd.user.paths."desktop-database" = {
      Unit.Description = "Watch for changes in $XDG_DATA_HOME/applications/";
      Path = {
        MakeDirectory = true;
        PathChanged = "%h/.local/share/applications";
      };
      Install.WantedBy = ["paths.target"];
    };
  };
}
