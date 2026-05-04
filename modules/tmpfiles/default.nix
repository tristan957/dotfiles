{
  config,
  lib,
  ...
}: {
  options.modules.tmpfiles.enable = lib.mkEnableOption "tmpfiles";

  config = lib.mkIf config.modules.tmpfiles.enable {
    systemd.user.tmpfiles.rules = [
      "D %h/Pictures/Screenshots"
      "D %h/Videos/Screencasts"
    ];
  };
}
