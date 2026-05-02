{
  config,
  lib,
  ...
}: {
  options.modules.hut.enable = lib.mkEnableOption "hut";

  config = lib.mkIf config.modules.hut.enable {
    xdg.configFile."hut/config".source = ./config;
  };
}
