{
  config,
  lib,
  ...
}: {
  options.modules.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf config.modules.direnv.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    xdg.configFile."direnv/direnv.toml".source = ./direnv.toml;
  };
}
