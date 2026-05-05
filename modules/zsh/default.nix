{
  config,
  lib,
  ...
}: {
  options.modules.zsh.enable = lib.mkEnableOption "zsh";

  config = lib.mkIf config.modules.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";

      history = {
        path = "${config.xdg.stateHome}/zsh/history";
        save = 1000000;
        size = 1000000;
        append = true;
        extended = true;
        expireDuplicatesFirst = true;
        ignoreDups = true;
      };

      envExtra = ''
        # Nix
        # Multi-user (daemon) installation
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 2>/dev/null
        # Fedora
        . /etc/profile.d/nix-daemon.sh 2>/dev/null
        # Single-user installation
        . "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.sh" 2>/dev/null

        # Make sure local binaries override everything
        export PATH="$HOME/.local/bin:$PATH"
      '';

      setOptions = ["numericglobsort"];

      initContent = ''
        [ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
        [ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"

        for f in "$XDG_CONFIG_HOME"/zsh/conf.d/*(N); do
          . "$f"
        done
      '';
    };

    xdg.configFile = {
      "zsh/conf.d/10-completion.zsh".source = ./10-completion.zsh;
      "zsh/conf.d/90-prompt.zsh".source = ./90-prompt.zsh;
    };
  };
}
