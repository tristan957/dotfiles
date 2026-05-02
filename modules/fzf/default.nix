{
  config,
  lib,
  ...
}: {
  options.modules.fzf.enable = lib.mkEnableOption "fzf";

  config = lib.mkIf config.modules.fzf.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      defaultOptions = ["--color=16" "--highlight-line"];
    };
  };
}
