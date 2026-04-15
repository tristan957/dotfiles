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
      extraPackages ? (_: []),
    }: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit username homeDirectory;
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
      };
      "dbltap@dbltap-dev" = mkHome {
        system = "x86_64-linux";
        username = "dbltap";
        homeDirectory = "/home/dbltap";
        extraPackages = pkgs:
          with pkgs; [
            _1password-cli
            aerc
            asciinema_3
            ast-grep
            alejandra
            bash
            bash-language-server
            bat
            bear
            bun
            chawan
            coccinelle
            copilot-language-server
            delta
            delve
            deno
            difftastic
            direnv
            ditaa
            fd
            fish
            fish-lsp
            fop
            fzf
            gh
            glab
            glow
            go
            golangci-lint
            gum
            hut
            just
            lazygit
            llvmPackages_22.clang-tools
            lua-language-server
            miller
            mold
            muon
            neovim
            nushell
            pandoc
            postgres-language-server
            reuse
            ripgrep
            rr
            ruff
            rustup
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
            zoxide
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
