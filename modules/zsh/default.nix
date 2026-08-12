{
  config,
  lib,
  ...
}: {
  config = {
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

      envExtra =
        # zsh
        ''
          # Nix
          # Multi-user (daemon) installation
          . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 2>/dev/null
          # Fedora
          . /etc/profile.d/nix-daemon.sh 2>/dev/null
          # Single-user installation
          . "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.sh" 2>/dev/null

          # Make sure local binaries override everything. .zshenv is sourced by
          # every zsh, including nested ones, so keep $path unique to stop the
          # entry accumulating. -U keeps the first occurrence, preserving order.
          typeset -U path PATH
          export PATH="${config.xdg.binHome}:$PATH"
        '';

      setOptions = ["numericglobsort"];

      # Replaces home-manager's own `autoload -U compinit && compinit`, which
      # is emitted whenever enableCompletion is set. Previously this lived in a
      # conf.d drop-in, which meant compinit ran twice per shell.
      completionInit =
        # zsh
        ''
          autoload -Uz compinit
          zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/zcompcache"
          compinit -d "${config.xdg.cacheHome}/zsh/zcompdump-$ZSH_VERSION"
        '';

      initContent =
        # zsh
        ''
          for f in "${config.xdg.configHome}"/zsh/conf.d/*(N); do
            . "$f"
          done
        '';
    };

    # compinit runs before initContent, so the cache directory cannot be
    # created from there. home-manager already creates the history directory.
    home.activation.createZshCacheDir =
      lib.hm.dag.entryAfter ["writeBoundary"]
      # bash
      ''
        mkdir -p "${config.xdg.cacheHome}/zsh"
      '';

    xdg.configFile = {
      "zsh/conf.d/90-prompt.zsh".source = ./90-prompt.zsh;
    };
  };
}
