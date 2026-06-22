{
  commonModules,
  emailModules,
  rustModules,
}: {
  stateVersion = "25.11";
  system = "aarch64-darwin";
  username = "dbltap";
  homeDirectory = "/Users/dbltap";
  modules =
    commonModules
    ++ emailModules
    ++ rustModules
    ++ [
      "comlink"
      "fonts"
      "ghostty"
      "kiro"
      "vscode"
    ];
  packages = pkgs:
    with pkgs; [
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
}
