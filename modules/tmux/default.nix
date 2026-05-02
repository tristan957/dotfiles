{
  config,
  lib,
  ...
}: {
  options.modules.tmux.enable = lib.mkEnableOption "tmux";

  config = lib.mkIf config.modules.tmux.enable {
    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  };
}
