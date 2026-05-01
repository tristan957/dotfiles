{config, ...}: {
  xdg.configFile."harper-ls/dictionary.txt".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/harper/.config/harper-ls/dictionary.txt";
}
