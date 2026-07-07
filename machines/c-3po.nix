{
  system = "x86_64-linux";

  machine = {
    config,
    pkgs,
    homeModules,
    ...
  }: let
    root = "${config.home.homeDirectory}/dotfiles";
  in {
    imports = with homeModules; [
      _1password
      aerc
      bash
      bat
      cargo
      chawan
      clangd
      comlink
      deno
      desktop-database
      direnv
      dotnet
      editline
      fish
      flatpak
      fonts
      fzf
      gdb
      ghostty
      git
      glow
      go
      harper
      helix
      hut
      jj
      just
      kubernetes
      lazygit
      less
      man
      meson
      mjmap
      neovim
      nix
      nnn
      node
      opencode
      programs
      psql
      ptyxis
      python
      readline
      ripgrep
      rlwrap
      rustup
      testcontainers
      tmpfiles
      tmux
      vim
      vscode
      zellij
      zoxide
      zsh
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
      flyctl
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
