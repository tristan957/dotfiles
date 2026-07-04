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
in
  inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {inherit homeModules;} // extraSpecialArgs;
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
