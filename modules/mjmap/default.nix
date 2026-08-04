{
  lib,
  pkgs,
  ...
}: {
  config = {
    xdg.configFile."mjmap/config.scfg".source = ./config.scfg;

    # I have fixed upstream mjmap to look at XDG_CONFIG_HOME on macOS, but
    # this has not made its way to a release yet
    home.file = lib.optionalAttrs pkgs.stdenv.isDarwin {
      "Library/Application Support/mjmap/config.scfg".source = ./config.scfg;
    };
  };
}
