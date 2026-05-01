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
      isCloudDesktop ? false,
      isMultiUserInstall ? true,
      isWorkMachine ? false,
      extraPackages ? (_: []),
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
          inherit username homeDirectory isCloudDesktop isMultiUserInstall isWorkMachine;
          isLinux = pkgs.stdenv.isLinux;
          machinePackages = extraPackages pkgs;
        };
        modules = [./home.nix];
      };
  in {
    homeConfigurations = {
      "dbltap@macbook" = mkHome {
        system = "aarch64-darwin";
        username = "dbltap";
        homeDirectory = "/Users/dbltap";
        isMultiUserInstall = true;
        isWorkMachine = true;
        extraPackages = pkgs:
          with pkgs; [
            _1password-cli
            alejandra
            asciinema_3
            ast-grep
            awscli2
            bashInteractive
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
            yq
            zellij
          ];
      };
      "dbltap@dbltap-dev" = mkHome {
        system = "x86_64-linux";
        username = "dbltap";
        homeDirectory = "/home/dbltap";
        isCloudDesktop = true;
        isMultiUserInstall = true;
        isWorkMachine = true;
        extraPackages = pkgs:
          with pkgs; [
            _1password-cli
            aerc
            asciinema_3
            ast-grep
            alejandra
            bashInteractive
            bash-language-server
            bear
            bun
            ccache
            chawan
            coccinelle
            copilot-language-server
            delta
            delve
            deno
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
            tinymist
            tmux
            tokei
            tree-sitter
            ts_query_ls
            ty
            typst
            vscode-langservers-extracted
            worktrunk
            zellij
            zig
            zls
            zsh
          ];
      };
      "dbltap@dbltap-lts" = mkHome {
        system = "x86_64-linux";
        username = "dbltap";
        homeDirectory = "/home/dbltap";
        isCloudDesktop = true;
        isMultiUserInstall = true;
        isWorkMachine = true;
        extraPackages = pkgs:
          with pkgs; [
            bashInteractive
            bear
            ccache
            copilot-language-server
            delta
            difftastic
            ditaa
            fop
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
            tmux
            tree-sitter
            vscode-langservers-extracted
            zellij
            zsh
          ];
      };
      "tristan957@c-3po" = mkHome {
        system = "x86_64-linux";
        username = "tristan957";
        homeDirectory = "/home/tristan957";
        isMultiUserInstall = true;
        extraPackages = pkgs:
          with pkgs; [
            alejandra
            ast-grep
            bash-language-server
            chawan
            copilot-language-server
            fish-lsp
            lua-language-server
            nh
            nixd
            vscode-langservers-extracted
            zls
          ];
      };
    };
  };
}
