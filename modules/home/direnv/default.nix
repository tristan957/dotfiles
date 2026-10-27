{
  inputs,
  pkgs,
  ...
}: {
  config = {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
        # Remove once nixpkgs ships a release containing 94e4fe0 (see flake.nix)
        package = inputs.nix-direnv.packages.${pkgs.stdenv.hostPlatform.system}.nix-direnv;
      };
    };

    xdg.configFile."direnv/direnv.toml".source = ./direnv.toml;
  };
}
