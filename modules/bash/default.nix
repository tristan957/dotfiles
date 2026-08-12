{config, ...}: let
  nixProfile = import ../../lib/nix-profile.nix;
in {
  config = {
    programs.bash = {
      enable = true;

      historyControl = [
        "ignoredups"
        "ignorespace"
      ];
      historyFile = "${config.xdg.stateHome}/bash/history";
      historyFileSize = 1000000;
      historySize = 1000000;

      shellOptions = [
        "checkwinsize"
        "failglob"
        "globstar"
        "histappend"
        "hostcomplete"
      ];

      logoutExtra = builtins.readFile ./bash_logout;

      profileExtra =
        nixProfile.posix
        +
        # bash
        ''

          # Make sure local binaries override everything
          export PATH="${config.xdg.binHome}:$PATH"
        '';

      initExtra =
        # bash
        ''
          HISTTIMEFORMAT='%FT%T%z: '

          # Source system bash files
          . "/etc/bash.bashrc" 2>/dev/null
          . "/etc/bashrc" 2>/dev/null

          # Interpolated rather than using $XDG_CONFIG_HOME, which is exported
          # from .profile and so is not guaranteed to be set here. This module
          # always installs files into bash.d, so failglob cannot trip on it.
          for f in "${config.xdg.configHome}"/bash.d/*; do
            . "$f"
          done
        '';
    };

    xdg.configFile = {
      "bash.d/90-aliases.sh".source = ./90-aliases.sh;
      "bash.d/90-completion.sh".source = ./90-completion.sh;
      "bash.d/90-prompt.sh".source = ./90-prompt.sh;
    };

    home.activation.createBashStateDir =
      config.lib.activation.mkDir "${config.xdg.stateHome}/bash";
  };
}
