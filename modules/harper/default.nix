{
  config,
  lib,
  ...
}: {
  options.modules.harper.enable = lib.mkEnableOption "harper";

  config = lib.mkIf config.modules.harper.enable {
    xdg.configFile."harper-ls/dictionary.txt".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/harper/dictionary.txt";
  };
}
