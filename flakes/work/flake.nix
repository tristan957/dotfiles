{
  description = "Work-specific Home Manager extensions";

  inputs = {
    dotfiles.url = "path:../..";
    amzn = {
      url = "git+ssh://git.amazon.com/pkg/AmznNix-Community";
      inputs.nixpkgs.follows = "dotfiles/nixpkgs";
      inputs.home-manager.follows = "dotfiles/home-manager";
      inputs.flake-parts.follows = "dotfiles/flake-parts";
      inputs.systems.follows = "dotfiles/systems";
    };
    # nur.follows = "dotfiles/nur";
    # Prebuilt binary; needs the pkgs.superlogical.com login in /etc/nix/netrc
    rex.url = "https://pkgs.superlogical.com/rex/nix/snapshot.tar.gz";
  };

  outputs = inputs @ {dotfiles, ...}: let
    inherit (dotfiles.lib) mkHome mkModules;

    homeModules = mkModules ./modules/home;
    mkWork = import ./lib/mk-work.nix {inherit inputs mkHome homeModules;};
  in {
    # Export all work dotfiles for external consumers
    inherit homeModules;

    homeConfigurations = {
      "dbltap@dbltap-dev" = mkWork (import ./machines/dbltap-dev.nix);
      "dbltap@dbltap-lts" = mkWork (import ./machines/dbltap-lts.nix);
      "dbltap@macbook" = mkWork (import ./machines/macbook.nix);
    };
  };
}
