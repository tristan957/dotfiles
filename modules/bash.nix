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
