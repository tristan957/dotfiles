{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    fonts.fontconfig.enable = true;

    # macOS does not read fontconfig, so fonts installed into the profile have
    # to be copied where CoreText will find them.
    home.activation.linkFonts = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (
      lib.hm.dag.entryAfter ["writeBoundary"]
      # bash
      ''
        run find -L ${lib.escapeShellArg "${config.home.profileDirectory}/share/fonts"} \
          \( -name "*.ttf" -o -name "*.otf" \) \
          -exec cp -fL {} ${lib.escapeShellArg "${config.home.homeDirectory}/Library/Fonts/"} \;
      ''
    );
  };
}
