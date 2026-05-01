{...}: {
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    _ZO_ECHO = "1";
  };
}
