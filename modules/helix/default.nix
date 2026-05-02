{
  config,
  lib,
  ...
}: {
  options.modules.helix.enable = lib.mkEnableOption "helix";

  config = lib.mkIf config.modules.helix.enable {
    xdg.configFile."helix".source = ./config;
  };
}
