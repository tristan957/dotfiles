{
  config,
  lib,
  ...
}: {
  options.modules.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf config.modules.neovim.enable {
    xdg.configFile."nvim".source =
      if config.dotfilesPath != null
      then
        config.lib.file.mkOutOfStoreSymlink
        "${config.dotfilesPath}/modules/neovim/nvim"
      else ./nvim;
  };
}
