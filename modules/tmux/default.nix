{config, ...}: {
  config = {
    home.file.".local/libexec/tmux/fzf-sessions" = config.lib.file.mkExecutable ./fzf-sessions;
    home.file.".local/libexec/tmux/session-input" = config.lib.file.mkExecutable ./session-input;

    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  };
}
