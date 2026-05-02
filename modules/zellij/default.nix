{
  config,
  lib,
  ...
}: {
  options.modules.zellij.enable = lib.mkEnableOption "zellij";

  config = lib.mkIf config.modules.zellij.enable {
    xdg.configFile."zellij".source = ./config;
  };
}
