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

    logoutExtra = builtins.readFile ../bash/.bash_logout;

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
}
