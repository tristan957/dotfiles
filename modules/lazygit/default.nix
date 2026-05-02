{
  config,
  lib,
  ...
}: {
  options.modules.lazygit.enable = lib.mkEnableOption "lazygit";

  config = lib.mkIf config.modules.lazygit.enable {
    xdg.configFile."lazygit/config.yml".source = ./config.yml;
  };
}
