{
  system = "aarch64-darwin";

  machine = {
    inputs,
    config,
    pkgs,
    ...
  }: let
    root = "${config.home.homeDirectory}/dotfiles";
  in {
    imports = with inputs.dotfiles.homeModules; [
      _1password
      aerc
      bash
      bat
      cargo
      chawan
      clangd
      comlink
      deno
      direnv
      dotnet
      editline
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
      vscode
      zellij
      zoxide
      zsh
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
      basedpyright
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
      inputs.bmux.packages.${pkgs.stdenv.hostPlatform.system}.default
      tofu-ls
      tokei
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
    ];
  };
}
