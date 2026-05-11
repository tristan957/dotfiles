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
    mkHome = {
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
          ./home.nix
          {
            modules = builtins.listToAttrs (map (name: {
                inherit name;
                value = {enable = true;};
              })
              modules);
            home.packages = packages pkgs;
          }
        ];
      };

    # Modules for Email support
    emailModules = [
      "aerc"
      "bat"
      "chawan"
      "mjmap"
    ];

    # Modules for Rust support
    rustModules = [
      "cargo"
      "rustup"
    ];

    commonModules = [
      "1password"
      "bash"
      "clangd"
      "deno"
      "direnv"
      "dotnet"
      "editline"
      "fish"
      "fzf"
      "git"
      "glow"
      "go"
      "harper"
      "helix"
      "hut"
      "jj"
      "jq"
      "just"
      "lazygit"
      "less"
      "man"
      "meson"
      "neovim"
      "nnn"
      "node"
      "programs"
      "psql"
      "python"
      "readline"
      "ripgrep"
      "rlwrap"
      "testcontainers"
      "tmux"
      "vim"
      "zellij"
      "zoxide"
      "zsh"
    ];
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

    homeConfigurations = {
      "dbltap@macbook" = mkHome {
        system = "aarch64-darwin";
        username = "dbltap";
        homeDirectory = "/Users/dbltap";
        modules =
          commonModules
          ++ emailModules
          ++ rustModules
          ++ [
            "comlink"
            "fonts"
            "ghostty"
            "kiro"
            "vscode"
          ];
        packages = pkgs:
          with pkgs; [
            _1password-cli
            alejandra
            asciinema_3
            ast-grep
            awscli2
            bash-language-server
            binutils
            bun
            cascadia-code
            chawan
            copilot-language-server
            coreutils-full
            curlFull
            delta
            delve
            # deno
            difftastic
            diffutils
            fd
            findutils
            fish-lsp
            gh
            git
            glab
            glow
            gnumake
            gnupatch
            gnused
            gnutar
            go
            golangci-lint
            gopls
            gum
            harper
            hut
            jj
            jq
            just
            lazygit
            lua-language-server
            miller
            mjmap
            moreutils
            muon
            neovim
            nh
            nixd
            nodejs
            nushell
            opentofu
            postgres-language-server
            reuse
            ruff
            rustup
            scdoc
            sequin
            sequoia-sq
            shellcheck
            shfmt
            stow
            stylua
            taplo
            time
            tinymist
            tmux
            tofu-ls
            tokei
            tree-sitter
            trurl
            ts_query_ls
            ty
            typst
            vhs
            vim
            vscode-langservers-extracted
            which
            yaml-language-server
            yq
            zellij
          ];
      };
      "dbltap@dbltap-dev" = mkHome {
        system = "x86_64-linux";
        username = "dbltap";
        homeDirectory = "/home/dbltap";
        modules =
          commonModules
          ++ emailModules
          ++ rustModules
          ++ [
            "cloud-desktop"
            "comlink"
            "desktop-database"
            "gdb"
            "kiro"
          ];
        packages = pkgs:
          with pkgs; [
            _1password-cli
            aerc
            asciinema_3
            ast-grep
            alejandra
            bash-language-server
            bear
            bun
            ccache
            chawan
            coccinelle
            copilot-language-server
            delta
            delve
            # deno
            difftastic
            ditaa
            fd
            fish-lsp
            fop
            gh
            glab
            glow
            go
            gopls
            golangci-lint
            gum
            harper
            hut
            just
            lazygit
            llvmPackages_22.clang-tools
            lua-language-server
            meson
            miller
            mjmap
            mold
            muon
            neovim
            nh
            nixd
            nodejs
            nushell
            pandoc
            postgres-language-server
            reuse
            rr
            ruff
            rustup
            samurai
            sccache
            scdoc
            sequin
            sequoia-sq
            shellcheck
            shfmt
            stow
            taplo
            tinymist
            tmux
            tokei
            tree-sitter
            ts_query_ls
            ty
            typst
            vscode-langservers-extracted
            worktrunk
            yaml-language-server
            zellij
            zig
            zls
          ];
      };
      "dbltap@dbltap-lts" = mkHome {
        system = "x86_64-linux";
        username = "dbltap";
        homeDirectory = "/home/dbltap";
        modules =
          commonModules
          ++ [
            "cloud-desktop"
            "extended-support"
            "gdb"
            "kiro"
          ];
        packages = pkgs:
          with pkgs; [
            _1password-cli
            bear
            ccache
            copilot-language-server
            delta
            difftastic
            ditaa
            fop
            harper
            lazygit
            llvmPackages_22.clang-tools
            meson
            mold
            muon
            nh
            nixd
            pandoc
            postgres-language-server
            neovim
            ninja
            rr
            samurai
            sccache
            stow
            taplo
            tmux
            tree-sitter
            vscode-langservers-extracted
            zellij
          ];
      };
      "tristan957@c-3po" = mkHome {
        system = "x86_64-linux";
        username = "tristan957";
        homeDirectory = "/home/tristan957";
        modules =
          commonModules
          ++ emailModules
          ++ rustModules
          ++ [
            "comlink"
            "desktop-database"
            "fonts"
            "gdb"
            "ghostty"
            "kubernetes"
            "ptyxis"
            "tmpfiles"
            "vscode"
          ];
        packages = pkgs:
          with pkgs; [
            alejandra
            ast-grep
            bash-language-server
            chawan
            copilot-language-server
            fish-lsp
            harper
            lua-language-server
            nh
            nixd
            taplo
            vscode-langservers-extracted
            yaml-language-server
            zls
          ];
      };
    };
  };
}
