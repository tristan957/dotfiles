{config, ...}: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    FZF_DEFAULT_OPTS_FILE = "${config.xdg.configHome}/fzf/fzfrc";
  };

  xdg.configFile."fzf/fzfrc".source = ../fzf/.config/fzf/fzfrc;
}
