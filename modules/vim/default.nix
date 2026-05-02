{
  config,
  lib,
  ...
}: {
  options.modules.vim.enable = lib.mkEnableOption "vim";

  config = lib.mkIf config.modules.vim.enable {
    xdg.configFile."vim".source = ./config;
  };
}
