{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    xdg.dataFile."app.devsuite.Ptyxis/palettes".source = ./palettes;
  };
}
