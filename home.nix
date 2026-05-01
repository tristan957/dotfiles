{
  config,
  lib,
  pkgs,
  username,
  homeDirectory,
  isMultiUserInstall,
  isCloudDesktop,
  isLinux,
  isWorkMachine,
  machinePackages ? [],
  ...
}: {
  imports =
    [
      ./modules/aerc.nix
      ./modules/bash.nix
      ./modules/bat.nix
      ./modules/cargo.nix
      ./modules/chawan.nix
      ./modules/clangd.nix
      ./modules/comlink.nix
      ./modules/deno.nix
      ./modules/direnv.nix
      ./modules/dotnet.nix
      ./modules/editline.nix
      ./modules/fish.nix
      ./modules/fzf.nix
      ./modules/gdb.nix
      ./modules/ghostty.nix
      ./modules/git.nix
      ./modules/go.nix
      ./modules/glow.nix
      ./modules/harper.nix
      ./modules/helix.nix
      ./modules/hut.nix
      ./modules/jj.nix
      ./modules/jq.nix
      ./modules/just.nix
      ./modules/kubernetes.nix
      ./modules/lazygit.nix
      ./modules/less.nix
      ./modules/man.nix
      ./modules/meson.nix
      ./modules/mjmap.nix
      ./modules/neovim.nix
      ./modules/nnn.nix
      ./modules/node.nix
      ./modules/programs.nix
      ./modules/psql.nix
      ./modules/python.nix
      ./modules/readline.nix
      ./modules/ripgrep.nix
      ./modules/rlwrap.nix
      ./modules/rustup.nix
      ./modules/testcontainers.nix
      ./modules/tmux.nix
      ./modules/vim.nix
      ./modules/zellij.nix
      ./modules/zoxide.nix
      ./modules/zsh.nix
    ]
    ++ lib.optionals isCloudDesktop [
      ./modules/cloud-desktop.nix
    ]
    ++ lib.optionals isWorkMachine [
      ./modules/work.nix
    ]
    ++ lib.optionals isLinux [
      ./modules/1password.nix
      ./modules/desktop-database.nix
      ./modules/ptyxis.nix
      ./modules/tmpfiles.nix
    ];

  home.username = username;
  home.homeDirectory = homeDirectory;

  xdg = {
    enable = true;
    cacheHome = "${homeDirectory}/.cache";
    configHome = "${homeDirectory}/.config";
    dataHome = "${homeDirectory}/.local/share";
    stateHome = "${homeDirectory}/.local/state";
  };

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
    ]
    ++ machinePackages;

  home.sessionVariables = {
    COLORTERM = "truecolor";
    EDITOR = "nvim";
    PAGER = "less";
  };

  fonts.fontconfig.enable = true;

  home.activation.linkFonts = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ "$(uname)" = "Darwin" ]; then
      fonts_dir="$HOME/Library/Fonts"
      find -L "${config.xdg.stateHome}/nix/profiles/home-manager/home-path/share/fonts" \( -name "*.ttf" -o -name "*.otf" \) -exec cp -fL {} "$fonts_dir/" \;
    fi
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
