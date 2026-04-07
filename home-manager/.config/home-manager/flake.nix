{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      mkHome =
        {
          system,
          username,
          homeDirectory,
          extraPackages ? (_: [ ]),
        }:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit username homeDirectory;
            machinePackages = extraPackages pkgs;
          };
          modules = [ ./home.nix ];
        };
    in
    {
      homeConfigurations = {
        "dbltap@macbook" = mkHome {
          system = "aarch64-darwin";
          username = "dbltap";
          homeDirectory = "/Users/dbltap";
        };
        "dbltap@dbltap-dev" = mkHome {
          system = "x86_64-linux";
          username = "dbltap";
          homeDirectory = "/home/dbltap";
          extraPackages = pkgs: [
            pkgs.fish
            pkgs.neovim
            pkgs.ripgrep
            pkgs.stow
            pkgs.tmux
            pkgs.tree-sitter
            pkgs.zellij
          ];
        };
        "tristan957@c-3po" = mkHome {
          system = "x86_64-linux";
          username = "tristan957";
          homeDirectory = "/home/tristan957";
        };
      };
    };
}
