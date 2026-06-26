{...}: {
  config = {
    home.file.".local/libexec/tmux/fzf-sessions" = {
      source = ./fzf-sessions;
      executable = true;
    };
    home.file.".local/libexec/tmux/session-input" = {
      source = ./session-input;
      executable = true;
    };
    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  };
}
