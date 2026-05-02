{
  config,
  lib,
  ...
}: {
  options.modules.mjmap.enable = lib.mkEnableOption "mjmap";

  config = lib.mkIf config.modules.mjmap.enable {
    xdg.configFile."mjmap/config.scfg".source = ./config.scfg;
  };
}
