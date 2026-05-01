{...}: {
  programs.bash = {
    enable = true;

    shellOptions = [
      "checkwinsize"
      "failglob"
      "globstar"
      "histappend"
      "hostcomplete"
      "nullglob"
    ];

    logoutExtra = builtins.readFile ./bash_logout;

    profileExtra = ''
      # Nix
      # Multi-user (daemon) installation
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 2>/dev/null
      # Fedora
      . /etc/profile.d/nix-daemon.fish 2>/dev/null
      # Single-user installation
      . "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.sh" 2>/dev/null
    '';

    initExtra = ''
      # Source system bash files
      . "/etc/bash.bashrc" 2>/dev/null
      . "/etc/bashrc" 2>/dev/null

      for f in "$XDG_CONFIG_HOME"/bash.d/*; do
        . "$f"
      done
    '';
  };

  xdg.configFile = {
    "bash.d/10-history.sh".source = ./10-history.sh;
    "bash.d/90-aliases.sh".source = ./90-aliases.sh;
    "bash.d/90-completion.sh".source = ./90-completion.sh;
    "bash.d/90-prompt.sh".source = ./90-prompt.sh;
  };
}
