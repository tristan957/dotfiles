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
        extraPackages = pkgs: [
          pkgs._1password-cli
          pkgs.asciinema_3
          pkgs.alejandra
          pkgs.bash
          pkgs.bash-language-server
          pkgs.bat
          pkgs.bear
          pkgs.chawan
          pkgs.copilot-language-server
          pkgs.delta
          pkgs.difftastic
          pkgs.direnv
          pkgs.fd
          pkgs.fish
          pkgs.fzf
          pkgs.gh
          pkgs.glab
          pkgs.glow
          pkgs.gum
          pkgs.hut
          pkgs.just
          pkgs.lazygit
          pkgs.llvmPackages_22.clang-tools
          pkgs.lua-language-server
          pkgs.miller
          pkgs.mold
          pkgs.muon
          pkgs.neovim
          pkgs.nushell
          pkgs.reuse
          pkgs.ripgrep
          pkgs.rr
          pkgs.ruff
          pkgs.sequin
          pkgs.sequoia-sq
          pkgs.shellcheck
          pkgs.shfmt
          pkgs.stow
          pkgs.tokei
          pkgs.tmux
          pkgs.tree-sitter
          pkgs.ts_query_ls
          pkgs.ty
          pkgs.vscode-langservers-extracted
          pkgs.worktrunk
          pkgs.zellij
          pkgs.zoxide
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
