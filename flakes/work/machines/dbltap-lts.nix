{
  system = "x86_64-linux";

  machine = {
    inputs,
    config,
    pkgs,
    homeModules,
    ...
  }: let
    root = "${config.home.homeDirectory}/dotfiles";
  in {
    imports =
      (with inputs.dotfiles.homeModules; [
        _1password
        bash
        clangd
        deno
        direnv
        dotnet
        editline
        fish
        fzf
        gdb
        git
        glow
        go
        harper
        helix
        hut
        jj
        just
        kiro
        lazygit
        less
        man
        meson
        neovim
        nix
        nnn
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
        zellij
        zoxide
        zsh
      ])
      ++ (with homeModules; [
        cloud-desktop
        extended-support
      ]);

    home.username = "dbltap";
    home.homeDirectory = "/home/dbltap";
    home.stateVersion = "25.11";

    modules.harper.symlink = "${root}/modules/harper/dictionary.txt";
    modules.neovim.symlink = "${root}/modules/neovim/nvim";

    home.packages = with pkgs; [
      _1password-cli
      bear
      ccache
      copilot-language-server
      delta
      difftastic
      ditaa
      fop
      harper
      lazygit
      llvmPackages_22.clang-tools
      meson
      mold
      muon
      neovim
      nh
      ninja
      nixd
      pandoc
      postgres-language-server
      rr
      samurai
      sccache
      stow
      taplo
      tmux
      tree-sitter
      vscode-langservers-extracted
      yaml-language-server
      zellij
    ];
  };
}
