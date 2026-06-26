{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    systemd.user.tmpfiles.rules = [
      "D %h/Pictures/Screenshots"
      "D %h/Videos/Screencasts"
    ];
  };
}
