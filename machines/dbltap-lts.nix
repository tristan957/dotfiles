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
      ../modules/bash
      ../modules/clangd
      ../modules/cloud-desktop
      ../modules/deno
      ../modules/direnv
      ../modules/dotnet
      ../modules/editline
      ../modules/extended-support
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
      ../modules/jq
      ../modules/just
      ../modules/kiro
      ../modules/lazygit
      ../modules/less
      ../modules/man
      ../modules/meson
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

    modules.harper.symlink = "${root}/modules/harper/dictionary.txt";
    modules.neovim.symlink = "${root}/modules/neovim/nvim";

    home.packages = with pkgs; [
      _1password-cli
      bear
      ccache
      copilot-language-server
      delta
      difftastic
      ditaa
      fop
      harper
      lazygit
      llvmPackages_22.clang-tools
      meson
      mold
      muon
      nh
      nixd
      pandoc
      postgres-language-server
      neovim
      ninja
      rr
      samurai
      sccache
      stow
      taplo
      tmux
      tree-sitter
      vscode-langservers-extracted
      yaml-language-server
      zellij
    ];
  };
}
