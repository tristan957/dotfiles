{
  config,
  lib,
  ...
}: let
  cfg = config.modules.harper;
in {
  options.modules.harper.symlink = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = ''
      Absolute path to symlink the harper dictionary from for live editing
      (out-of-store symlink). Null uses the Nix store copy.
    '';
  };

  config = {
    xdg.configFile."harper-ls/dictionary.txt".source =
      if cfg.symlink != null
      then config.lib.file.mkOutOfStoreSymlink cfg.symlink
      else ./dictionary.txt;
  };
}
