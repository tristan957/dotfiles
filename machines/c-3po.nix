{
  system = "x86_64-linux";

  machine = {
    config,
    homeModules,
    lib,
    pkgs,
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
      delta
      desktop-database
      devenv
      difftastic
      direnv
      dotnet
      editline
      fastmail
      fedora
      fish
      flatpak
      fonts
      fzf
      gdb
      ghostty
      git
      git-absorb
      glow
      go
      helix
      hunk
      hut
      jj
      just
      kubernetes
      lazygit
      less
      man
      mcp
      meson
      mjmap
      neovim
      nh
      nix
      node
      opencode
      programs
      psql
      ptyxis
      python
      readline
      rex
      ripgrep
      rlwrap
      rustup
      skills
      testcontainers
      tmpfiles
      vercel
      vim
      zoxide
      zsh
    ];

    home.username = "tristan957";
    home.homeDirectory = "/home/tristan957";
    home.stateVersion = "25.11";

    programs.nh.homeFlake = "${root}";

    home.packages = with pkgs; [
      alejandra
      ast-grep
      bash-language-server
      copilot-language-server
      fish-lsp
      flyctl
      harper
      lua-language-server
      nix-auth
      nixd
      (lib.hiPrio rust-analyzer)
      shfmt
      svelte-language-server
      tombi
      vacuum-go
      vscode-langservers-extracted
      yaml-language-server
      zls
    ];
  };
}
