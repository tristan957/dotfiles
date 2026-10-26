{
  config,
  inputs,
  pkgs,
  ...
}: let
in {
  imports = [inputs.rex.homeManagerModules.default];

  programs.rex.enable = true;
  programs.rex.sshGuard = false;
  services.rex.enable = pkgs.stdenv.hostPlatform.isLinux;
}
