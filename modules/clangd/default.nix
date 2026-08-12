{
  lib,
  pkgs,
  ...
}: {
  config = {
    # clangd reads ~/Library/Preferences on darwin instead of following XDG.
    xdg.configFile = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      "clangd/config.yaml".source = ./config.yaml;
    };

    home.file = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      "Library/Preferences/clangd/config.yaml".source = ./config.yaml;
    };
  };
}
