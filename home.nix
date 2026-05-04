{
  lib,
  username,
  homeDirectory,
  ...
}: {
  options.dotfilesPath = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = "${homeDirectory}/dotfiles";
    description = "Path to local dotfiles checkout. Null uses Nix store paths.";
  };

  config = {
    home.username = username;
    home.homeDirectory = homeDirectory;
    home.stateVersion = "25.11";

    xdg = {
      enable = true;
      cacheHome = "${homeDirectory}/.cache";
      configHome = "${homeDirectory}/.config";
      dataHome = "${homeDirectory}/.local/share";
      stateHome = "${homeDirectory}/.local/state";
    };

    home.sessionVariables = {
      COLORTERM = "truecolor";
      EDITOR = "nvim";
      PAGER = "less";
    };

    programs.home-manager.enable = true;
  };

  imports = [
    ./modules/1password
    ./modules/aerc
    ./modules/bash
    ./modules/bat
    ./modules/cargo
    ./modules/chawan
    ./modules/clangd
    ./modules/cloud-desktop
    ./modules/comlink
    ./modules/deno
    ./modules/desktop-database
    ./modules/direnv
    ./modules/dotnet
    ./modules/editline
    ./modules/fish
    ./modules/fonts
    ./modules/fzf
    ./modules/gdb
    ./modules/ghostty
    ./modules/git
    ./modules/go
    ./modules/glow
    ./modules/harper
    ./modules/helix
    ./modules/hut
    ./modules/jj
    ./modules/jq
    ./modules/just
    ./modules/kiro
    ./modules/kubernetes
    ./modules/lazygit
    ./modules/less
    ./modules/man
    ./modules/meson
    ./modules/mjmap
    ./modules/neovim
    ./modules/nix
    ./modules/nnn
    ./modules/node
    ./modules/programs
    ./modules/psql
    ./modules/ptyxis
    ./modules/python
    ./modules/readline
    ./modules/ripgrep
    ./modules/rlwrap
    ./modules/rustup
    ./modules/testcontainers
    ./modules/tmux
    ./modules/tmpfiles
    ./modules/vim
    ./modules/vscode
    ./modules/zellij
    ./modules/zoxide
    ./modules/zsh
  ];
}
