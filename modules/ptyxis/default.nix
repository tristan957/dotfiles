{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.ptyxis.enable = lib.mkEnableOption "ptyxis";

  config = lib.mkIf (config.modules.ptyxis.enable && pkgs.stdenv.isLinux) {
    xdg.dataFile."app.devsuite.Ptyxis/palettes".source = ./palettes;
  };
}
