{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });

    configModule = import ./lib/config-module.nix;
  in {
    lib.mkPostgresDeps = import ./lib/mk-postgres-deps.nix {inherit configModule;};
    checks = import ./checks.nix {inherit self forAllSystems;};
    devShells = forAllSystems ({pkgs}: {
      default = import ./dev-shells/default.nix {inherit pkgs;};
    });
  };
}
