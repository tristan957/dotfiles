{
  config,
  lib,
  ...
}: {
  options.modules.tmux.enable = lib.mkEnableOption "tmux";

  config = lib.mkIf config.modules.tmux.enable {
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
