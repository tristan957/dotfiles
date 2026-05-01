{...}: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    defaultOptions = ["--color=16" "--highlight-line"];
  };
}
