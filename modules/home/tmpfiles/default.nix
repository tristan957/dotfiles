{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    systemd.user.tmpfiles.rules = [
      "D %h/Pictures/Screenshots"
      "D %h/Videos/Screencasts"
    ];
  };
}
