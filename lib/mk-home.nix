{
  nixpkgs,
  home-manager,
}: {
  system,
  machine,
}: let
  pkgs = import nixpkgs {
    inherit system;

    # Allow unfree packages like 1Password CLI
    config.allowUnfree = true;
  };
in
  home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [
      # Base configuration shared by every machine.
      {
        home.enableNixpkgsReleaseCheck = false;

        xdg.enable = true;

        home.sessionVariables = {
          COLORTERM = "truecolor";
        };

        programs.home-manager.enable = true;
      }
      machine
    ];
  }
