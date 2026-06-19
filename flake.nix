{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    nixpkgs,
    home-manager,
    systems,
    ...
  }: let
    mkHome = import ./lib/mk-home.nix {inherit nixpkgs home-manager;};
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
    inherit (import ./machines/common.nix) commonModules emailModules rustModules;
  in {
    devShells = forEachSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = pkgs.mkShell {
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
    });

    homeManagerModules.default = ./home.nix;

    homeConfigurations = let
      machineArgs = {inherit commonModules emailModules rustModules;};
    in {
      "dbltap@macbook" = mkHome (import ./machines/macbook.nix machineArgs);
      "dbltap@dbltap-dev" = mkHome (import ./machines/dbltap-dev.nix machineArgs);
      "dbltap@dbltap-lts" = mkHome (import ./machines/dbltap-lts.nix machineArgs);
      "tristan957@c-3po" = mkHome (import ./machines/c-3po.nix machineArgs);
    };
  };
}
