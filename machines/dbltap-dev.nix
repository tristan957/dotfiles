{
  system = "x86_64-linux";

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
      ../modules/cloud-desktop
      ../modules/comlink
      ../modules/deno
      ../modules/desktop-database
      ../modules/direnv
      ../modules/dotnet
      ../modules/editline
      ../modules/fish
      ../modules/fzf
      ../modules/gdb
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
      ../modules/zellij
      ../modules/zoxide
      ../modules/zsh
    ];

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
      hut
      just
      lazygit
      llvmPackages_22.clang-tools
      lua-language-server
      meson
      miller
      mjmap
      mold
      muon
      neovim
      nh
      nixd
      nodejs
      nushell
      pandoc
      postgres-language-server
      reuse
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
      tmux
      tokei
      tree-sitter
      ts_query_ls
      ty
      typst
      vscode-langservers-extracted
      worktrunk
      yaml-language-server
      zellij
      zig
      zls
    ];
  };
}
