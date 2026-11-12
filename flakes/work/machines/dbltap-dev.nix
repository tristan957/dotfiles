{
  system = "x86_64-linux";

  machine = {
    config,
    homeModules,
    inputs,
    lib,
    pkgs,
    ...
  }: let
    root = "${config.home.homeDirectory}/dotfiles";
  in {
    imports =
      (with inputs.dotfiles.homeModules; [
        _1password
        aerc
        asciinema
        awscli
        bash
        bat
        bun
        cargo
        chawan
        clangd
        comlink
        delta
        deno
        desktop-database
        devenv
        difftastic
        direnv
        dotnet
        editline
        fastmail
        fd
        fish
        fzf
        gdb
        git
        git-absorb
        glow
        go
        helix
        hunk
        hut
        jj
        jq
        just
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
        nushell
        opencode
        programs
        psql
        python
        readline
        rex
        ripgrep
        rlwrap
        ruff
        rustup
        skills
        testcontainers
        ty
        uv
        vim
        zoxide
        zsh
      ])
      ++ (with homeModules; [
        cloud-desktop
        go
        jj
      ]);

    home.username = "dbltap";
    home.homeDirectory = "/home/dbltap";
    home.stateVersion = "25.11";

    programs.nh.homeFlake = "${root}/flakes/work";

    home.packages = (
      with pkgs; [
        _1password-cli
        aerc
        alejandra
        ast-grep
        basedpyright
        bash-language-server
        bear
        ccache
        clang
        # Broken: depends on ocaml-pcre, which is marked broken in nixpkgs
        # coccinelle
        codespell
        copilot-language-server
        delve
        ditaa
        fish-lsp
        fop
        (lib.hiPrio gcc)
        gh
        glab
        golangci-lint
        gopls
        gum
        harper
        lazygit
        lldb
        llvmPackages_23.clang-tools
        lua-language-server
        miller
        mold
        muon
        mypy
        nix-auth
        nixd
        pandoc
        pkgconf
        postgres-language-server
        reuse
        (python314.withPackages (ps:
          with ps; [
            matplotlib
            pytest
          ]))
        rr
        (lib.hiPrio rust-analyzer)
        samurai
        sccache
        scdoc
        sequin
        sequoia-sq
        shellcheck
        shfmt
        tinymist
        tombi
        tokei
        tree-sitter
        ts_query_ls
        typst
        vscode-langservers-extracted
        worktrunk
        yaml-language-server
        zig
        zls
      ]
    );
  };
}
