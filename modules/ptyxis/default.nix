{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    programs.ptyxis.enable = true;

    programs.ptyxis.palettes = {
      One-Vivid = {
        Palette.Name = "One Vivid";
        Dark = {
          Background = "#282c34";
          # Foreground = #abb2bf;
          Foreground = "#ffffff";

          Color0 = "#282c34";
          Color8 = "#5c6370";

          Color1 = "#ef596f";
          Color9 = "#f38897";

          Color2 = "#89ca78";
          Color10 = "#a9d89d";

          Color3 = "#e5c07b";
          Color11 = "#edd4a6";

          Color4 = "#61afef";
          Color12 = "#8fc6f4";

          Color5 = "#d55fde";
          Color13 = "#e089e7";

          Color6 = "#2bbac5";
          Color14 = "#4bced8";

          Color7 = "#abb2bf";
          Color15 = "#c8cdd5";
        };
        Light = {
          Background = "#fafafa";
          # Foreground = #6a6a6a
          Foreground = "#000000";

          Color0 = "#6a6a6a";
          Color8 = "#bebebe";

          Color1 = "#e05661";
          Color9 = "#e88189";

          Color2 = "#1da912";
          Color10 = "#25d717";

          Color3 = "#eea825";
          Color11 = "#f2bb54";

          Color4 = "#118dc3";
          Color12 = "#1caceb";

          Color5 = "#9a77cf";
          Color13 = "#b69ddc";

          Color6 = "#56b6c2";
          Color14 = "#7bc6d0";

          Color7 = "#fafafa";
          Color15 = "#ffffff";
        };
      };
    };
  };
}
