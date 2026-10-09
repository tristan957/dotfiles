{...}: {
  config = {
    programs.fzf = {
      enable = true;
      defaultOptions = ["--color=16" "--highlight-line"];
    };
  };
}
