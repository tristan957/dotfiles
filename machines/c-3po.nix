{
  system = "x86_64-linux";

  machine = {
    config,
    pkgs,
    ...
  }: let
    root = "${config.home.homeDirectory}/dotfiles";
  in {
    imports = [
      ../modules/1password
      ../modules/aerc
      ../modules/bash
      ../modules/bat
      ../modules/cargo
      ../modules/chawan
      ../modules/clangd
      ../modules/comlink
      ../modules/deno
      ../modules/desktop-database
      ../modules/direnv
      ../modules/dotnet
      ../modules/editline
      ../modules/fish
      ../modules/fonts
      ../modules/fzf
      ../modules/gdb
      ../modules/ghostty
      ../modules/git
      ../modules/glow
      ../modules/go
      ../modules/harper
      ../modules/helix
      ../modules/hut
      ../modules/jj
      ../modules/just
      ../modules/kubernetes
      ../modules/lazygit
      ../modules/less
      ../modules/man
      ../modules/meson
      ../modules/mjmap
      ../modules/neovim
      ../modules/nix
      ../modules/nnn
      ../modules/node
      ../modules/opencode
      ../modules/programs
      ../modules/psql
      ../modules/ptyxis
      ../modules/python
      ../modules/readline
      ../modules/ripgrep
      ../modules/rlwrap
      ../modules/rustup
      ../modules/testcontainers
      ../modules/tmpfiles
      ../modules/tmux
      ../modules/vim
      ../modules/vscode
      ../modules/zellij
      ../modules/zoxide
      ../modules/zsh
    ];

    home.username = "tristan957";
    home.homeDirectory = "/home/tristan957";
    home.stateVersion = "25.11";

    modules.aerc.symlink = "${root}/modules/aerc/accounts.conf";
    modules.harper.symlink = "${root}/modules/harper/dictionary.txt";
    modules.neovim.symlink = "${root}/modules/neovim/nvim";

    home.packages = with pkgs; [
      alejandra
      ast-grep
      bash-language-server
      chawan
      copilot-language-server
      fish-lsp
      git-absorb
      harper
      lua-language-server
      nh
      nixd
      taplo
      vscode-langservers-extracted
      yaml-language-server
      zls
    ];
  };
}
