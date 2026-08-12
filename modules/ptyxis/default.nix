{
  lib,
  pkgs,
  ...
}: let
  palette = (import ../../lib/palettes.nix).one-vivid;

  # Ptyxis names each entry Color<N>, alongside Background and Foreground.
  mkVariant = variant:
    {
      Background = variant.background;
      Foreground = variant.foreground;
    }
    // lib.listToAttrs (
      lib.imap0 (i: color: {
        name = "Color${toString i}";
        value = color;
      })
      variant.colors
    );
in {
  config = lib.mkIf pkgs.stdenv.isLinux {
    programs.ptyxis.enable = true;
    programs.ptyxis.package = null;

    programs.ptyxis.palettes = {
      One-Vivid = {
        Palette.Name = palette.name;
        Dark = mkVariant palette.dark;
        Light = mkVariant palette.light;
      };
    };
  };
}
