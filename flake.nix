{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ {
    flake-parts,
    home-manager,
    nixpkgs,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: let
      mkHome = import ./lib/mk-home.nix {inherit nixpkgs home-manager;};
      inherit (import ./machines/common.nix) commonModules emailModules rustModules;
    in {
      systems = import systems;

      perSystem = {pkgs, ...}: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            bashInteractive
            fish
            lua-language-server
            luajitPackages.luacheck
            markdownlint-cli2
            nixd
            prettier
            reuse
            ruff
            shellcheck
            shfmt
            stylua
            ty
            vscode-langservers-extracted
            zsh
          ];
        };
      };

      flake = {
        homeConfigurations = let
          machineArgs = {inherit commonModules emailModules rustModules;};
        in {
          "dbltap@macbook" = mkHome (import ./machines/macbook.nix machineArgs);
          "dbltap@dbltap-dev" = mkHome (import ./machines/dbltap-dev.nix machineArgs);
          "dbltap@dbltap-lts" = mkHome (import ./machines/dbltap-lts.nix machineArgs);
          "tristan957@c-3po" = mkHome (import ./machines/c-3po.nix machineArgs);
        };

        homeModules.default = ./home.nix;
      };
    });
}
