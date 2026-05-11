{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    mkHome = import ./lib/mk-home.nix {inherit nixpkgs home-manager;};
    inherit (import ./machines/common.nix) commonModules emailModules rustModules;
  in {
    devShells = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"] (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          alejandra
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
