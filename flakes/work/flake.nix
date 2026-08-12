{
  description = "Work-specific Home Manager extensions";

  inputs = {
    dotfiles.url = "path:../..";
    amzn = {
      url = "git+ssh://git.amazon.com/pkg/AmznNix-Community";
      inputs.nixpkgs.follows = "dotfiles/nixpkgs";
      inputs.home-manager.follows = "dotfiles/home-manager";
      inputs.flake-parts.follows = "dotfiles/flake-parts";
      inputs.systems.follows = "dotfiles/systems";
    };
    bmux.follows = "dotfiles/bmux";
    nur.follows = "dotfiles/nur";
  };

  outputs = inputs @ {dotfiles, ...}: let
    inherit (dotfiles.lib) mkHome mkHomeModules;

    homeModules = mkHomeModules ./modules;
    mcp = import ./lib/mcp.nix {inherit (dotfiles.lib) mcp;};
    mkWork = import ./lib/mk-work.nix {inherit inputs mkHome homeModules mcp;};
  in {
    # Export all work dotfiles for external consumers
    inherit homeModules;

    # The shared MCP catalogue extended with the work-only servers, so
    # downstream consumers do not have to reassemble it
    lib = {inherit mcp;};

    homeConfigurations = {
      "dbltap@dbltap-dev" = mkWork (import ./machines/dbltap-dev.nix);
      "dbltap@dbltap-lts" = mkWork (import ./machines/dbltap-lts.nix);
      "dbltap@macbook" = mkWork (import ./machines/macbook.nix);
    };
  };
}
