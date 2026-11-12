{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.neovim;
in {
  options.dotfiles.neovim.package = lib.mkPackageOption pkgs "neovim" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    home.sessionVariables.EDITOR = "nvim";

    xdg.configFile."nvim".source = ./nvim;
  };
}
