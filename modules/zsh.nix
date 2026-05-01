{config, ...}: {
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    envExtra = ''
      # Nix
      # Multi-user (daemon) installation
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 2>/dev/null
      # Fedora
      . /etc/profile.d/nix-daemon.fish 2>/dev/null
      # Single-user installation
      . "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.sh" 2>/dev/null
    '';

    initContent = ''
      setopt numericglobsort

      [ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
      [ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"

      for f in "$XDG_CONFIG_HOME"/zsh/conf.d/*(N); do
        . "$f"
      done
    '';
  };
}
