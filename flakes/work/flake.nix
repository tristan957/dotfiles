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
    flake-parts.follows = "dotfiles/flake-parts";
    nixpkgs.follows = "dotfiles/nixpkgs";
    # nur.follows = "dotfiles/nur";
    rex.follows = "dotfiles/rex";
    systems.follows = "dotfiles/systems";
  };

  outputs = inputs @ {
    dotfiles,
    flake-parts,
    nixpkgs,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: let
      inherit (dotfiles.lib) mkHome mkModules mkNixConf;

      homeModules = mkModules ./modules/home;
      mkWork = import ./lib/mk-work.nix {inherit inputs mkHome homeModules;};

      daemon = "${dotfiles}/modules/home/nix/conf.d";
    in {
      systems = import systems;

      perSystem = {pkgs, ...}: {
        packages.nix-conf = mkNixConf pkgs [
          "${daemon}/nix.conf"
          "${daemon}/numtide.conf"
          "${daemon}/go-proxy.conf"
        ];
      };

      flake = {
        # Export all work dotfiles for external consumers
        inherit homeModules;

        homeConfigurations = {
          "dbltap@dbltap-dev" = mkWork (import ./machines/dbltap-dev.nix);
          "dbltap@dbltap-lts" = mkWork (import ./machines/dbltap-lts.nix);
          "dbltap@macbook" = mkWork (import ./machines/macbook.nix);
        };
      };
    });
}
