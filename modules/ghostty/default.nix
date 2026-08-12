{
  lib,
  pkgs,
  ...
}: let
  palette = (import ../../lib/palettes.nix).one-vivid;

  # Ghostty takes explicit "N=#rrggbb" entries. Emitted low/high paired to
  # match how the palette reads in ghostty's own documentation.
  mkTheme = variant: {
    inherit (variant) background foreground;
    palette =
      lib.concatMap (i: [
        "${toString i}=${builtins.elemAt variant.colors i}"
        "${toString (i + 8)}=${builtins.elemAt variant.colors (i + 8)}"
      ])
      (lib.range 0 7);
    split-divider-color = variant.divider;
    window-titlebar-background = variant.titlebar;
  };
in {
  config = {
    programs.ghostty = {
      enable = true;
      package = null;

      settings =
        {
          auto-update = "off";

          bell-features = "no-audio,no-system,no-title";

          clipboard-paste-bracketed-safe = true;
          clipboard-paste-protection = true;
          clipboard-trim-trailing-spaces = true;

          confirm-close-surface = true;

          copy-on-select = true;

          cursor-click-to-move = true;
          cursor-color = "cell-foreground";
          cursor-style = "block";
          cursor-style-blink = "";
          cursor-text = "cell-background";

          desktop-notifications = true;

          focus-follows-mouse = false;

          font-family = "Cascadia Mono PL";
          # Disable ligatures
          font-feature = [
            "-calt"
            "-liga"
            "-dlig"
          ];
          font-size =
            if pkgs.stdenv.hostPlatform.isDarwin
            then 13
            else 10;

          keybind =
            [
              "super+ctrl+\\=new_split:right"
              "super+ctrl+-=new_split:down"
            ]
            ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
              # GTK Inspector
              "ctrl+shift+d=ignore"
              "ctrl+shift+e=unbind"
              "ctrl+shift+i=ignore"
              "ctrl+shift+o=toggle_tab_overview"
              "ctrl+alt+shift+i=inspector:toggle"
            ];

          link-url = true;

          mouse-hide-while-typing = false;
          mouse-scroll-multiplier = "discrete:1,precision:1";

          notify-on-command-finish = "unfocused";
          notify-on-command-finish-action = "bell,notify";
          notify-on-command-finish-after = "5s";

          palette-generate = true;
          palette-harmonious = true;

          progress-style = true;

          resize-overlay = "after-first";
          resize-overlay-position = "bottom-right";

          selection-background = "cell-foreground";
          selection-foreground = "cell-background";

          shell-integration = "detect";
          shell-integration-features = "no-cursor,title,ssh-terminfo,sudo";

          theme = "light:one_light,dark:one_dark_vivid";

          unfocused-split-opacity = 1;

          window-decoration = true;
          window-height = 24;
          window-inherit-font-size = true;
          window-inherit-working-directory = true;
          window-padding-color = "background";
          window-padding-x = 4;
          window-padding-y = 4;
          window-subtitle = "working-directory";
          window-theme = "ghostty";
          window-width = 80;
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
          macos-auto-secure-input = true;
          macos-hidden = "never";
          macos-icon = "official";
          macos-secure-input-indication = true;
          macos-window-shadow = true;
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
          linux-cgroup = "always";
        };

      themes = {
        one_dark_vivid = mkTheme palette.dark;
        one_light = mkTheme palette.light;
      };

      systemd = {
        enable = false;
      };
    };

    # Enable the ghostty systemd user service if ghostty is installed and
    # systemctl is available. The service unit is shipped by ghostty itself
    # (not via nixpkgs), so we can only enable it when it actually exists.
    #
    # `systemctl cat` is used as the test because `list-unit-files` exits 0 even
    # when nothing matches its pattern, which would let the enable below run and
    # fail on a host without the unit, aborting activation.
    home.activation.enableGhosttyService = lib.mkIf pkgs.stdenv.hostPlatform.isLinux (
      lib.hm.dag.entryAfter ["writeBoundary"]
      # bash
      ''
        if systemctl --user cat app-com.mitchellh.ghostty.service >/dev/null 2>&1; then
          run systemctl --user enable --now app-com.mitchellh.ghostty.service
        fi
      ''
    );
  };
}
