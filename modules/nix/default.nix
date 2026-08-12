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
      # use-xdg-base-directories is set at the /etc/nix/nix.conf level (see the
      # note below), so home-manager cannot infer it from its own settings and
      # has to be told. Without this, config.home.profileDirectory resolves to
      # ~/.nix-profile and config.nix.defexprDir to ~/.nix-defexpr, neither of
      # which exists on these machines.
      assumeXdg = true;

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      package = lib.mkDefault pkgs.nix;
      settings = lib.optionalAttrs (!config.modules.nix.isMultiUserInstall) {
        # These are trusted settings that make much more sense to set at the
        # /etc/nix/nix.conf level. Otherwise you get warnings like the following:
        #
        # warning: ignoring the client-specified setting
        # 'use-xdg-base-directories', because it is a restricted setting and you
        # are not a trusted user
        auto-optimise-store = true;
        extra-experimental-features = [
          "flakes"
          "nix-command"
        ];
        use-xdg-base-directories = true;
      };
    };
  };
}
