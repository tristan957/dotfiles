{config, ...}: {
  xdg.configFile."harper-ls/dictionary.txt".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/modules/harper/dictionary.txt";
}
