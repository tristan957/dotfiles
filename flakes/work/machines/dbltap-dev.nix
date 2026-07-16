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
        fzf
        gdb
        git
        glow
        go
        harper
        helix
        hunk
        hut
        jj
        just
        kiro
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
        python
        readline
        ripgrep
        rlwrap
        rustup
        testcontainers
        tmux
        vim
        zellij
        zoxide
        zsh
      ])
      ++ (with homeModules; [
        cloud-desktop
        go
      ]);

    home.username = "dbltap";
    home.homeDirectory = "/home/dbltap";
    home.stateVersion = "25.11";

    modules.aerc.symlink = "${root}/modules/aerc/accounts.conf";
    modules.harper.symlink = "${root}/modules/harper/dictionary.txt";
    modules.neovim.symlink = "${root}/modules/neovim/nvim";

    home.packages = with pkgs; [
      _1password-cli
      aerc
      alejandra
      asciinema
      ast-grep
      basedpyright
      bash-language-server
      bear
      bun
      ccache
      chawan
      clang
      coccinelle
      copilot-language-server
      delta
      delve
      # deno
      difftastic
      ditaa
      fd
      fish-lsp
      fop
      gh
      git
      git-absorb
      glab
      glow
      go
      golangci-lint
      gopls
      gum
      harper
      hunk
      hut
      just
      lazygit
      lldb
      llvmPackages_22.clang-tools
      lua-language-server
      meson
      miller
      mjmap
      mold
      muon
      mypy
      neovim
      nh
      nixd
      nodejs
      nushell
      pandoc
      postgres-language-server
      reuse
      (python314.withPackages (ps:
        with ps; [
          matplotlib
          pytest
        ]))
      rr
      ruff
      rustup
      samurai
      sccache
      scdoc
      sequin
      sequoia-sq
      shellcheck
      shfmt
      stow
      taplo
      tinymist
      inputs.bmux.packages.${pkgs.stdenv.hostPlatform.system}.default
      tokei
      tree-sitter
      ts_query_ls
      ty
      typst
      uv
      vscode-langservers-extracted
      worktrunk
      yaml-language-server
      zellij
      zig
      zls
    ];
  };
}
