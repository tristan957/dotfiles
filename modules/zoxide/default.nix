{
  config,
  lib,
  ...
}: {
  options.modules.zoxide.enable = lib.mkEnableOption "zoxide";

  config = lib.mkIf config.modules.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    home.sessionVariables = {
      _ZO_ECHO = "1";
    };
  };
}
