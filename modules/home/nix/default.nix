{
  lib,
  pkgs,
  ...
}: {
  config = {
    nix = {
      # use-xdg-base-directories is set at the /etc/nix/nix.conf level, which
      # home-manager cannot see, so it has to be told. Without this,
      # config.home.profileDirectory resolves to ~/.nix-profile and
      # config.nix.defexprDir to ~/.nix-defexpr, neither of which exists on
      # these machines.
      #
      # It is set there rather than here because it is a restricted setting;
      # a client-specified value is ignored for untrusted users, with:
      #
      # warning: ignoring the client-specified setting
      # 'use-xdg-base-directories', because it is a restricted setting and you
      # are not a trusted user
      assumeXdg = true;

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      package = lib.mkDefault pkgs.nix;
    };
  };
}
