{
  commonModules,
  emailModules,
  rustModules,
}: {
  system = "x86_64-linux";
  username = "tristan957";
  homeDirectory = "/home/tristan957";
  modules =
    commonModules
    ++ emailModules
    ++ rustModules
    ++ [
      "comlink"
      "desktop-database"
      "fonts"
      "gdb"
      "ghostty"
      "kubernetes"
      "ptyxis"
      "tmpfiles"
      "vscode"
    ];
  packages = pkgs:
    with pkgs; [
      alejandra
      ast-grep
      bash-language-server
      chawan
      copilot-language-server
      fish-lsp
      harper
      lua-language-server
      nh
      nixd
      taplo
      vscode-langservers-extracted
      yaml-language-server
      zls
    ];
}
