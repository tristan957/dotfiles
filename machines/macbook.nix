{
  system = "aarch64-darwin";

  machine = {
    config,
    pkgs,
    ...
  }: let
    root = "${config.home.homeDirectory}/dotfiles";
  in {
    imports = [
      ../modules/1password
      ../modules/aerc
      ../modules/bash
      ../modules/bat
      ../modules/cargo
      ../modules/chawan
      ../modules/clangd
      ../modules/comlink
      ../modules/deno
      ../modules/direnv
      ../modules/dotnet
      ../modules/editline
      ../modules/fish
      ../modules/fonts
      ../modules/fzf
      ../modules/ghostty
      ../modules/git
      ../modules/glow
      ../modules/go
      ../modules/harper
      ../modules/helix
      ../modules/hut
      ../modules/jj
      ../modules/just
      ../modules/kiro
      ../modules/lazygit
      ../modules/less
      ../modules/man
      ../modules/meson
      ../modules/mjmap
      ../modules/neovim
      ../modules/nix
      ../modules/nnn
      ../modules/node
      ../modules/opencode
      ../modules/programs
      ../modules/psql
      ../modules/python
      ../modules/readline
      ../modules/ripgrep
      ../modules/rlwrap
      ../modules/rustup
      ../modules/testcontainers
      ../modules/tmux
      ../modules/vim
      ../modules/vscode
      ../modules/zellij
      ../modules/zoxide
      ../modules/zsh
    ];

    home.username = "dbltap";
    home.homeDirectory = "/Users/dbltap";
    home.stateVersion = "25.11";

    modules.aerc.symlink = "${root}/modules/aerc/accounts.conf";
    modules.harper.symlink = "${root}/modules/harper/dictionary.txt";
    modules.neovim.symlink = "${root}/modules/neovim/nvim";

    home.packages = with pkgs; [
      _1password-cli
      alejandra
      asciinema
      ast-grep
      awscli2
      bash-language-server
      binutils
      bun
      cascadia-code
      chawan
      copilot-language-server
      coreutils-full
      curlFull
      delta
      delve
      # deno
      difftastic
      diffutils
      fd
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
      go
      golangci-lint
      gopls
      gum
      harper
      hut
      jj
      jq
      just
      lazygit
      lua-language-server
      meson
      miller
      mjmap
      moreutils
      muon
      neovim
      nh
      ninja
      nixd
      nodejs
      nushell
      opentofu
      postgres-language-server
      reuse
      ruff
      rustup
      samurai
      scdoc
      sequin
      sequoia-sq
      shellcheck
      shfmt
      stow
      stylua
      taplo
      time
      tinymist
      tmux
      tofu-ls
      tokei
      tree-sitter
      trurl
      ts_query_ls
      ty
      typst
      vhs
      vim
      vscode-langservers-extracted
      which
      yaml-language-server
      yq
      zellij
    ];
  };
}
