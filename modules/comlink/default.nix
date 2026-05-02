{
  config,
  lib,
  ...
}: {
  options.modules.comlink.enable = lib.mkEnableOption "comlink";

  config = lib.mkIf config.modules.comlink.enable {
    xdg.configFile."comlink/init.lua".source = ./init.lua;
  };
}
