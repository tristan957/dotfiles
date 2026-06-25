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
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

      imports = [inputs.treefmt-nix.flakeModule];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        treefmt = {
          projectRootFile = "flake.nix";

          programs = {
            alejandra.enable = true;
            prettier.enable = true;
            ruff-format.enable = true;
            stylua.enable = true;

            shfmt = {
              enable = true;
              indent_size = 4;
              simplify = false;
              includes = [
                "*.bash"
                "*.sh"
                "modules/aerc/aerc-signature"
                "modules/bash/bash_logout"
                "modules/programs/dbgwait"
                "modules/tmux/fzf-sessions"
              ];
            };
          };

          settings = {
            excludes = [
              # lazy.nvim manages these lockfiles; do not format them
              "*/lazy-lock.json"
            ];

            formatter.shfmt.options = [
              "--case-indent"
              "--language-dialect"
              "bash"
            ];
          };
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [config.treefmt.build.devShell];

          packages = with pkgs; [
            bashInteractive
            fish
            lua-language-server
            luajitPackages.luacheck
            markdownlint-cli2
            nixd
            reuse
            ruff
            shellcheck
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
