{config, lib, ...}: {
  fonts.fontconfig.enable = true;

  home.activation.linkFonts = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ "$(uname)" = "Darwin" ]; then
      fonts_dir="$HOME/Library/Fonts"
      find -L "${config.xdg.stateHome}/nix/profiles/home-manager/home-path/share/fonts" \( -name "*.ttf" -o -name "*.otf" \) -exec cp -fL {} "$fonts_dir/" \;
    fi
  '';
}
