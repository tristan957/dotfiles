{
  system = "aarch64-darwin";

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

    home.packages = (
      with pkgs;
        [
          _1password-cli
          alejandra
          ast-grep
          basedpyright
          bash-language-server
          cascadia-code
          copilot-language-server
          coreutils-full
          curlFull
          delta
          delve
          # deno
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
          jj
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
          nushell
          opentofu
          pkgconf
          postgres-language-server
          reuse
          rustup
          samurai
          scdoc
          sequin
          sequoia-sq
          shellcheck
          shfmt
          stow
          stylua
          time
          tinymist
          tofu-ls
          tokei
          tombi
          tree-sitter
          trurl
          ts_query_ls
          ty
          typst
          uv
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
