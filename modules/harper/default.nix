{
  config,
  lib,
  ...
}: let
  cfg = config.modules.harper;
  symlink = import ../../lib/symlink.nix {inherit lib;};
in {
  options.modules.harper.symlink = symlink.mkOption "the harper dictionary";

  config = {
    xdg.configFile."harper-ls/dictionary.txt".source =
      symlink.select config cfg.symlink ./dictionary.txt;
  };
}
