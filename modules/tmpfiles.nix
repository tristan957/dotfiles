{...}: {
  systemd.user.tmpfiles.rules = [
    "D %h/Pictures/Screenshots"
    "D %h/Videos/Screencasts"
  ];
}
