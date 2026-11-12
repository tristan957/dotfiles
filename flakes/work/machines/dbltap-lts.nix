{
  system = "x86_64-linux";

  machine = {
    config,
    homeModules,
    inputs,
    pkgs,
    ...
  }: let
    root = "${config.home.homeDirectory}/dotfiles";
  in {
    imports =
      (with inputs.dotfiles.homeModules; [
        _1password
        bash
        clangd
        delta
        deno
        difftastic
        direnv
        dotnet
        editline
        fish
        fzf
        gdb
        git
        glow
        go
        helix
        hut
        jj
        just
        lazygit
        less
        man
        meson
        neovim
        nh
        nix
        node
        opencode
        programs
        psql
        python
        readline
        ripgrep
        rlwrap
        testcontainers
        tmux
        vim
        zoxide
        zsh
      ])
      ++ (with homeModules; [
        cloud-desktop
        extended-support
        go
        jj
      ]);

    home.username = "dbltap";
    home.homeDirectory = "/home/dbltap";
    home.stateVersion = "25.11";

    programs.nh.homeFlake = "${root}/flakes/work";

    home.packages = with pkgs; [
      _1password-cli
      bear
      ccache
      copilot-language-server
      ditaa
      fop
      harper
      lazygit
      llvmPackages_23.clang-tools
      mold
      muon
      ninja
      nix-auth
      nixd
      pandoc
      postgres-language-server
      rr
      samurai
      sccache
      tombi
      tree-sitter
      vscode-langservers-extracted
      yaml-language-server
    ];
  };
}
