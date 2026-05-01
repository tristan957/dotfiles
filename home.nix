{
  config,
  lib,
  pkgs,
  username,
  homeDirectory,
  isMultiUserInstall,
  machinePackages ? [],
  ...
}: {
  imports = [
    ./modules/deno.nix
    ./modules/dotnet.nix
    ./modules/go.nix
    ./modules/jq.nix
    ./modules/less.nix
    ./modules/nnn.nix
    ./modules/node.nix
    ./modules/python.nix
    ./modules/rustup.nix
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;

  xdg.stateHome = "${homeDirectory}/.local/state";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ]
    ++ machinePackages;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dbltap/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  fonts.fontconfig.enable = true;

  home.activation.linkFonts = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ "$(uname)" = "Darwin" ]; then
      fonts_dir="$HOME/Library/Fonts"
      find -L "${config.xdg.stateHome}/nix/profiles/home-manager/home-path/share/fonts" \( -name "*.ttf" -o -name "*.otf" \) -exec cp -fL {} "$fonts_dir/" \;
    fi
  '';

  programs.fish = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # man-db does not work on macOS because it uses a different system
  programs.man.enable = !pkgs.stdenv.isDarwin;

  nix = {
    package = pkgs.nix;
    settings = lib.mkIf (!isMultiUserInstall) {
      # These are trusted settings that make much more sense to set at the
      # /etc/nix/nix.conf level. Otherwise you get warnings like the following:
      #
      # warning: ignoring the client-specified setting
      # 'use-xdg-base-directories', because it is a restricted setting and you
      # are not a trusted user
      use-xdg-base-directories = true;
      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };
}
