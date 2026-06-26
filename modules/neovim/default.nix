{
  config,
  lib,
  ...
}: let
  cfg = config.modules.neovim;
in {
  options.modules.neovim.symlink = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = ''
      Absolute path to symlink the Neovim config from for live editing
      (out-of-store symlink). Null uses the Nix store copy.
    '';
  };

  config = {
    home.sessionVariables.EDITOR = "nvim";

    xdg.configFile."nvim".source =
      if cfg.symlink != null
      then config.lib.file.mkOutOfStoreSymlink cfg.symlink
      else ./nvim;
  };
}
