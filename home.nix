{
  lib,
  username,
  homeDirectory,
  isCloudDesktop,
  isLinux,
  isWorkMachine,
  machinePackages ? [],
  ...
}: {
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  home.packages = machinePackages;

  home.sessionVariables = {
    COLORTERM = "truecolor";
    EDITOR = "nvim";
    PAGER = "less";
  };

  xdg = {
    enable = true;
    cacheHome = "${homeDirectory}/.cache";
    configHome = "${homeDirectory}/.config";
    dataHome = "${homeDirectory}/.local/share";
    stateHome = "${homeDirectory}/.local/state";
  };

  programs.home-manager.enable = true;

  imports =
    [
      ./modules/aerc
      ./modules/bash
      ./modules/bat
      ./modules/cargo
      ./modules/chawan
      ./modules/clangd
      ./modules/comlink
      ./modules/deno
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
      ./modules/python
      ./modules/readline
      ./modules/ripgrep
      ./modules/rlwrap
      ./modules/rustup
      ./modules/testcontainers
      ./modules/tmux
      ./modules/vim
      ./modules/vscode
      ./modules/zellij
      ./modules/zoxide
      ./modules/zsh
    ]
    ++ lib.optionals isCloudDesktop [
      ./modules/cloud-desktop
    ]
    ++ lib.optionals isLinux [
      ./modules/1password
      ./modules/desktop-database
      ./modules/ptyxis
      ./modules/tmpfiles
    ]
    ++ lib.optionals isWorkMachine [
      ./modules/work
    ];
}
