{...}: {
  xdg.configFile."git".source = ../git/.config/git;

  home.file = {
    ".local/bin/git-credential-bw" = {source = ../git/.local/bin/git-credential-bw; executable = true;};
    ".local/bin/git-credential-op" = {source = ../git/.local/bin/git-credential-op; executable = true;};
    ".local/bin/git-user" = {source = ../git/.local/bin/git-user; executable = true;};
    ".local/bin/interactive-diff" = {source = ../git/.local/bin/interactive-diff; executable = true;};
  };
}
