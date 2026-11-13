{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.hunk;
in {
  options.dotfiles.hunk.package = lib.mkPackageOption pkgs "hunk" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    xdg.configFile."hunk/config.toml" = {
      text =
        # toml
        ''
          mode = "auto"
          theme = "terminal"
          tab_width = 4
        '';
    };
  };
}
