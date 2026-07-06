{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: let
      mkHomeModules = import ./lib/home-modules.nix;
      homeModules = mkHomeModules ./modules;
      mkHome = import ./lib/mk-home.nix {inherit inputs homeModules;};
    in {
      systems = import systems;

      # Expose the evaluated flake-parts option set (debug.options,
      # allSystems.<system>.options, ...) so editors/nixd can offer completion
      # and docs for perSystem options like treefmt and pre-commit.
      debug = true;

      imports = [
        inputs.git-hooks.flakeModule
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {
        config,
        lib,
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
              # flake.lock is managed by nix
              "*/flake.lock"
              # lazy.nvim manages these lockfiles
              "*/lazy-lock.json"
            ];

            formatter.shfmt.options = [
              "--case-indent"
              "--language-dialect"
              "bash"
            ];
          };
        };

        pre-commit.settings.hooks = {
          luacheck.enable = true;

          # markdownlint-cli2 reads .markdownlint-cli2.yaml from the repo root.
          # Defined as a custom hook because the predefined `markdownlint` hook
          # wraps markdownlint-cli (v1), which uses inline config instead.
          markdownlint-cli2 = {
            enable = true;
            name = "markdownlint-cli2";
            entry = "${pkgs.markdownlint-cli2}/bin/markdownlint-cli2";
            files = "\\.md$";
          };
          reuse.enable = true;
          ruff.enable = true;
          shellcheck = {
            enable = true;
            types_or = lib.mkForce [];
            files = lib.concatStringsSep "|" [
              "\\.sh$"
              "^modules/aerc/aerc-signature$"
              "^modules/bash/bash_logout$"
              "^modules/programs/dbgwait$"
            ];
            args = [
              "--shell"
              "bash"
              "--external-sources"
            ];
          };

          # Run treefmt as a hook so commits are formatted
          treefmt = {
            enable = true;
            package = config.treefmt.build.wrapper;
          };
        };

        devShells.default = pkgs.mkShellNoCC {
          inputsFrom = [
            config.pre-commit.devShell
            config.treefmt.build.devShell
          ];

          packages = with pkgs; [
            bashInteractive
            fish
            lua-language-server
            luajitPackages.luacheck
            markdownlint-cli2
            nixd
            (python314.withPackages (ps:
              with ps; [
                matplotlib
              ]))
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
        # Export all dotfiles for external consumers
        inherit homeModules;

        # Re-export helpers so downstream flakes (e.g. flakes/work) can build
        # their own machine configurations against this repo's modules, and
        # generate their own `homeModules` from a modules directory
        lib = {
          inherit mkHome mkHomeModules;
        };

        homeConfigurations = {
          "tristan957@c-3po" = mkHome (import ./machines/c-3po.nix);
        };
      };
    });
}
