{
  commonModules,
  ...
}: {
  system = "x86_64-linux";
  username = "dbltap";
  homeDirectory = "/home/dbltap";
  modules =
    commonModules
    ++ [
      "cloud-desktop"
      "extended-support"
      "gdb"
      "kiro"
    ];
  packages = pkgs:
    with pkgs; [
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
      zellij
    ];
}
