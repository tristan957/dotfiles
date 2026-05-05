{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.tmpfiles.enable = lib.mkEnableOption "tmpfiles";

  config = lib.mkIf (config.modules.tmpfiles.enable && pkgs.stdenv.isLinux) {
    systemd.user.tmpfiles.rules = [
      "D %h/Pictures/Screenshots"
      "D %h/Videos/Screencasts"
    ];
  };
}
