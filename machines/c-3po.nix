{
  system = "x86_64-linux";

  machine = {
    config,
    inputs,
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
      nh
      nix
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

    modules.harper.symlink = "${root}/modules/harper/dictionary.txt";
    modules.neovim.symlink = "${root}/modules/neovim/nvim";

    programs.go.package = null;

    home.packages = with pkgs;
      [
        alejandra
        ast-grep
        bash-language-server
        copilot-language-server
        fish-lsp
        flyctl
        git-absorb
        harper
        hunk
        lua-language-server
        nix-auth
        nixd
        rustup
        tombi
        vacuum-go
        vscode-langservers-extracted
        yaml-language-server
        zls
      ]
      ++ [
        inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.Freed-Wu.tmux-language-server
      ];
  };
}
