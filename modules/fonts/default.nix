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
    #
    # config.home.profileDirectory is deliberately not used: it derives from
    # nix.useXdg, which is off, so it resolves to ~/.nix-profile even though
    # this machine keeps its profiles under XDG state.
    home.activation.linkFonts = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (
      lib.hm.dag.entryAfter ["writeBoundary"]
      # bash
      ''
        run find -L ${lib.escapeShellArg "${config.xdg.stateHome}/nix/profiles/home-manager/home-path/share/fonts"} \
          \( -name "*.ttf" -o -name "*.otf" \) \
          -exec cp -fL {} ${lib.escapeShellArg "${config.home.homeDirectory}/Library/Fonts/"} \;
      ''
    );
  };
}
