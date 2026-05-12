{
  commonModules,
  emailModules,
  rustModules,
}: {
  system = "x86_64-linux";
  username = "dbltap";
  homeDirectory = "/home/dbltap";
  modules =
    commonModules
    ++ emailModules
    ++ rustModules
    ++ [
      "cloud-desktop"
      "comlink"
      "desktop-database"
      "gdb"
      "kiro"
    ];
  packages = pkgs:
    with pkgs; [
      _1password-cli
      aerc
      asciinema
      ast-grep
      alejandra
      bash-language-server
      bear
      bun
      ccache
      chawan
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
      glab
      glow
      go
      gopls
      golangci-lint
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
}
