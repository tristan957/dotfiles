{
  config,
  lib,
  ...
}: {
  options.modules.chawan.enable = lib.mkEnableOption "chawan";

  config = lib.mkIf config.modules.chawan.enable {
    xdg.configFile."chawan/config.toml".source = ./config.toml;
  };
}
