{
  config,
  lib,
  ...
}: let
  cfg = config.modules.neovim;
  symlink = import ../../lib/symlink.nix {inherit lib;};
in {
  options.modules.neovim.symlink = symlink.mkOption "the Neovim config";

  config = {
    home.sessionVariables.EDITOR = "nvim";

    xdg.configFile."nvim".source =
      symlink.select config cfg.symlink ./nvim;
  };
}
