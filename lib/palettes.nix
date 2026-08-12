# Shared terminal colour schemes.
#
# The ghostty and ptyxis modules each render these into their own configuration
# format. Keeping the values in one place stops the two terminals drifting
# apart, which had already happened once: the light foreground was #323232 in
# ghostty but #000000 in ptyxis.
#
# `colors` is indexed by ANSI colour number, so `colors` element N is colour N.
{
  one-vivid = {
    name = "One Vivid";

    dark = {
      background = "#282c34";
      foreground = "#ffffff";
      divider = "#5c6370";
      titlebar = "#303643";

      colors = [
        "#282c34" # 0
        "#ef596f" # 1
        "#89ca78" # 2
        "#e5c07b" # 3
        "#61afef" # 4
        "#d55fde" # 5
        "#2bbac5" # 6
        "#abb2bf" # 7
        "#5c6370" # 8
        "#f38897" # 9
        "#a9d89d" # 10
        "#edd4a6" # 11
        "#8fc6f4" # 12
        "#e089e7" # 13
        "#4bced8" # 14
        "#c8cdd5" # 15
      ];
    };

    light = {
      background = "#fafafa";
      foreground = "#323232";
      divider = "#bebebe";
      titlebar = "#fafafa";

      colors = [
        "#6a6a6a" # 0
        "#e05661" # 1
        "#1da912" # 2
        "#eea825" # 3
        "#118dc3" # 4
        "#9a77cf" # 5
        "#56b6c2" # 6
        "#fafafa" # 7
        "#bebebe" # 8
        "#e88189" # 9
        "#25d717" # 10
        "#f2bb54" # 11
        "#1caceb" # 12
        "#b69ddc" # 13
        "#7bc6d0" # 14
        "#ffffff" # 15
      ];
    };
  };
}
