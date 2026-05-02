{
  config,
  lib,
  ...
}: {
  options.modules.jj.enable = lib.mkEnableOption "jj";

  config = lib.mkIf config.modules.jj.enable {
    xdg.configFile."jj".source = ./config;
  };
}
