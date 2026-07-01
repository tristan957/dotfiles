{
  lib,
  pkgs,
  ...
}: {
  config = {
    xdg.configFile = {
      "ghostty/config.ghostty".source = ./config.ghostty;
      "ghostty/themes".source = ./themes;
    };

    home.file = lib.mkIf pkgs.stdenv.isDarwin {
      "Library/Application Support/com.mitchellh.ghostty/config.ghostty" = {
        source = ./config.darwin.ghostty;
        force = true;
      };
    };

    # Enable the ghostty systemd user service if ghostty is installed and
    # systemctl is available. The service unit is shipped by ghostty itself
    # (not via nixpkgs), so we can only enable it when it actually exists.
    home.activation.enableGhosttyService = lib.mkIf pkgs.stdenv.isLinux (
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        if systemctl --user list-unit-files app-com.mitchellh.ghostty.service >/dev/null 2>&1; then
          run systemctl --user enable --now app-com.mitchellh.ghostty.service
        fi
      ''
    );
  };
}
