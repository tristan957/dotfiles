{
  config,
  lib,
  ...
}: {
  options.modules.tmux.enable = lib.mkEnableOption "tmux";

  config = lib.mkIf config.modules.tmux.enable {
    home.file.".local/bin/fzf-tmux-sessions" = {
      source = ./fzf-tmux-sessions;
      executable = true;
    };
    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  };
}
