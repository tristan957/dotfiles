{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.vim;
in {
  options.dotfiles.vim.package = lib.mkPackageOption pkgs "vim" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    xdg.configFile."vim".source = ./config;
  };
}
