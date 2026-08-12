{
  config,
  lib,
  ...
}: {
  config = {
    programs.nh = {
      enable = true;

      # Machines whose configuration lives in a nested flake (e.g. the work
      # flake) override this.
      flake = lib.mkDefault "${config.home.homeDirectory}/dotfiles";
    };
  };
}
