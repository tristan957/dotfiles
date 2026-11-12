{
  system = "aarch64-darwin";

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
        devenv
        difftastic
        direnv
        dotnet
        editline
        fastmail
        fd
        fish
        fonts
        fzf
        ghostty
        git
        git-absorb
        glow
        go
        helix
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
        go
        jj
      ]);

    home.username = "dbltap";
    home.homeDirectory = "/Users/dbltap";
    home.stateVersion = "25.11";

    programs.nh.homeFlake = "${root}/flakes/work";

    home.packages = (
      with pkgs; [
        _1password-cli
        alejandra
        ast-grep
        basedpyright
        bash-language-server
        cascadia-code
        codespell
        copilot-language-server
        coreutils-full
        curlFull
        delve
        diffutils
        findutils
        fish-lsp
        gh
        glab
        glow
        gnumake
        gnupatch
        gnused
        gnutar
        golangci-lint
        gopls
        gum
        harper
        hunk
        hut
        just
        lazygit
        lldb
        lua-language-server
        meson
        miller
        mjmap
        moreutils
        # muon
        neovim
        ninja
        nix-auth
        nixd
        nodejs
        opentofu
        pkgconf
        postgres-language-server
        python3
        reuse
        (lib.hiPrio rust-analyzer)
        # samurai
        scdoc
        sequin
        sequoia-sq
        shellcheck
        shfmt
        stylua
        svelte-language-server
        time
        tinymist
        tofu-ls
        tokei
        tombi
        tree-sitter
        trurl
        ts_query_ls
        typst
        vhs
        vim
        vscode-langservers-extracted
        which
        yaml-language-server
        yq
      ]
    );
  };
}
