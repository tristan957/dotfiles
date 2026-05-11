{
  nixpkgs,
  home-manager,
}: {
  system,
  username,
  homeDirectory,
  modules,
  packages ? (_: []),
}: let
  pkgs = import nixpkgs {
    inherit system;

    # Allow unfree packages like 1Password CLI
    config.allowUnfree = true;

    overlays = [
      (final: prev: {
        # direnv's checkPhase seems to struggle if direnv is loaded
        direnv = prev.direnv.overrideAttrs {doCheck = false;};
      })
    ];
  };
in
  home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      inherit username homeDirectory;
    };
    modules = [
      ../home.nix
      {
        modules = builtins.listToAttrs (map (name: {
            inherit name;
            value = {enable = true;};
          })
          modules);
        home.packages = packages pkgs;
      }
    ];
  }
