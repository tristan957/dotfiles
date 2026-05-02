{
  config,
  lib,
  ...
}: {
  options.modules.glow.enable = lib.mkEnableOption "glow";

  config = lib.mkIf config.modules.glow.enable {
    xdg.configFile."glow/glow.yml".source = ./glow.yml;
  };
}
