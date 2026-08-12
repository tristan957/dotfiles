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
        asciinema
        awscli
        bash
        bat
        bun
        cargo
        chawan
        clangd
        comlink
        deno
        desktop-database
        direnv
        dotnet
        editline
        fd
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
        jq
        just
        lazygit
        less
        man
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
        ripgrep
        rlwrap
        ruff
        rustup
        testcontainers
        tmux
        ty
        uv
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

    modules.harper.symlink = "${root}/modules/harper/dictionary.txt";
    modules.neovim.symlink = "${root}/modules/neovim/nvim";

    programs.nh.flake = "${root}/flakes/work";

    home.packages = (
      with pkgs;
        [
          _1password-cli
          aerc
          alejandra
          ast-grep
          basedpyright
          bash-language-server
          bear
          ccache
          clang
          coccinelle
          codespell
          copilot-language-server
          delta
          delve
          difftastic
          ditaa
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
          nix-auth
          nixd
          nodejs
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
          (pkgs.lib.hiPrio pkgs.rust-analyzer)
          samurai
          sccache
          scdoc
          sequin
          sequoia-sq
          shellcheck
          shfmt
          tombi
          tinymist
          tokei
          tree-sitter
          ts_query_ls
          typst
          vscode-langservers-extracted
          worktrunk
          yaml-language-server
          zellij
          zig
          zls
        ]
        ++ [
          inputs.bmux.packages.${pkgs.stdenv.hostPlatform.system}.default
          inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.Freed-Wu.tmux-language-server
        ]
    );
  };
}
