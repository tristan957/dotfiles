{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.nix.isMultiUserInstall = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = {
    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      package = lib.mkDefault pkgs.nix;
      settings = lib.mkIf (!config.modules.nix.isMultiUserInstall) {
        # These are trusted settings that make much more sense to set at the
        # /etc/nix/nix.conf level. Otherwise you get warnings like the following:
        #
        # warning: ignoring the client-specified setting
        # 'use-xdg-base-directories', because it is a restricted setting and you
        # are not a trusted user
        extra-experimental-features = [
          "flakes"
          "nix-command"
        ];
        use-xdg-base-directories = true;
      };
    };
  };
}
