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
        # Custom helpers, exposed alongside home-manager's own under
        # config.lib.file (e.g. config.lib.file.mkExecutable).
        lib.file.mkExecutable = import ./mk-executable.nix;

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
