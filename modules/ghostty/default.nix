{
  lib,
  pkgs,
  ...
}: {
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
            if pkgs.stdenv.isDarwin
            then 13
            else 10;

          keybind =
            [
              "super+ctrl+\\=new_split:right"
              "super+ctrl+-=new_split:down"
            ]
            ++ lib.optionals pkgs.stdenv.isLinux [
              # GTK Inspector
              "ctrl+shift+d=ignore"
              "ctrl+shift+e=unbind"
              "ctrl+shift+i=ignore"
              "ctrl+shift+o=toggle_tab_overview"
              "ctrl+alt+shift+i=inspector:toggle"
            ];

          link-url = true;

          mouse-hide-while-typing = false;

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
        // lib.optionalAttrs pkgs.stdenv.isDarwin {
          macos-auto-secure-input = true;
          macos-hidden = "never";
          macos-icon = "official";
          macos-secure-input-indication = true;
          macos-window-shadow = true;
        }
        // lib.optionalAttrs pkgs.stdenv.isLinux {
          linux-cgroup = "always";
        };

      themes = {
        one_dark_vivid = {
          background = "#282c34";
          foreground = "#ffffff";
          palette = [
            "0=#282c34"
            "8=#5c6370"
            "1=#ef596f"
            "9=#f38897"
            "2=#89ca78"
            "10=#a9d89d"
            "3=#e5c07b"
            "11=#edd4a6"
            "4=#61afef"
            "12=#8fc6f4"
            "5=#d55fde"
            "13=#e089e7"
            "6=#2bbac5"
            "14=#4bced8"
            "7=#abb2bf"
            "15=#c8cdd5"
          ];
          split-divider-color = "#5c6370";
          # Value comes from Ptyxis :)
          window-titlebar-background = "#303643";
        };

        one_light = {
          background = "#fafafa";
          foreground = "#323232";
          palette = [
            "0=#6a6a6a"
            "8=#bebebe"
            "1=#e05661"
            "9=#e88189"
            "2=#1da912"
            "10=#25d717"
            "3=#eea825"
            "11=#f2bb54"
            "4=#118dc3"
            "12=#1caceb"
            "5=#9a77cf"
            "13=#b69ddc"
            "6=#56b6c2"
            "14=#7bc6d0"
            "7=#fafafa"
            "15=#ffffff"
          ];
          split-divider-color = "#bebebe";
          # Value comes from Ptyxis :)
          window-titlebar-background = "#fafafa";
        };
      };

      systemd = {
        enable = false;
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
