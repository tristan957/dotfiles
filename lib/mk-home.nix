{
  inputs,
  # The repository's Home Manager modules, exposed so machine configurations
  # can import them by name (e.g. `homeModules.git`) regardless of where the
  # machine file lives on disk (which lets machine files live in other flakes,
  # e.g. flakes/work).
  homeModules,
}: {
  system,
  machine,
  # Extra module arguments, merged over the defaults and exposed to all
  # modules (including in `imports`). Downstream flakes (e.g. flakes/work) use
  # this to inject their own values such as `dotfiles` and to override
  # `homeModules` with their own module set.
  extraSpecialArgs ? {},
}: let
  pkgs = import inputs.nixpkgs {
    inherit system;

    # Allow unfree packages like 1Password CLI
    config.allowUnfree = true;
  };

  # This repo's own packages (see `flake.nix`'s `packages.<name>` outputs
  # and `pkgs/`), exposed to modules as `dotfilesPackages`
  dotfilesPackages = inputs.self.packages.${system};
in
  inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {inherit inputs homeModules dotfilesPackages;} // extraSpecialArgs;
    modules =
      [
        # Base configuration shared by every machine.
        ({lib, ...}: {
          # Custom helpers, exposed alongside home-manager's own under
          # config.lib (e.g. config.lib.file.mkExecutable).
          lib.file.mkExecutable = import ./mk-executable.nix;
          lib.activation.mkDir = import ./mk-dir.nix {inherit lib;};

          home.enableNixpkgsReleaseCheck = false;

          xdg.enable = true;

          home.sessionVariables = {
            COLORTERM = "truecolor";
          };

          programs.home-manager.enable = true;
        })
        machine
      ]
      # nix-flatpak is only meaningful on Linux (flatpak does not exist on macOS).
      ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
        inputs.flatpak.homeManagerModules.nix-flatpak
      ];
  }
