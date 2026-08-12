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
        deno
        direnv
        dotnet
        editline
        fd
        fish
        fonts
        fzf
        ghostty
        git
        glow
        go
        harper
        helix
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
        vscode
        zellij
        zoxide
        zsh
      ])
      ++ (with homeModules; [
        go
      ]);

    home.username = "dbltap";
    home.homeDirectory = "/Users/dbltap";
    home.stateVersion = "25.11";

    modules.harper.symlink = "${root}/modules/harper/dictionary.txt";
    modules.neovim.symlink = "${root}/modules/neovim/nvim";

    programs.nh.flake = "${root}/flakes/work";

    home.packages = (
      with pkgs;
        [
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
          delta
          delve
          difftastic
          diffutils
          findutils
          fish-lsp
          gh
          git
          git-absorb
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
          jujutsu
          just
          lazygit
          lldb
          lua-language-server
          meson
          miller
          mjmap
          moreutils
          muon
          neovim
          ninja
          nix-auth
          nixd
          nodejs
          opentofu
          pkgconf
          postgres-language-server
          reuse
          (lib.hiPrio rust-analyzer)
          samurai
          scdoc
          sequin
          sequoia-sq
          shellcheck
          shfmt
          stylua
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
          zellij
        ]
        ++ [
          inputs.bmux.packages.${pkgs.stdenv.hostPlatform.system}.default
          inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.Freed-Wu.tmux-language-server
        ]
    );
  };
}
