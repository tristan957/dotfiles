{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  rexWithSkill = inputs.rex.packages.${pkgs.stdenv.hostPlatform.system}.rex.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.installAgentSkills];
    postInstall =
      (old.postInstall or "")
      + ''
        export HOME=$TMPDIR/home
        mkdir -p "$HOME"
        $out/bin/rex skill setup --agent opencode --autostart=false
        installSkill "$HOME/.agents/skills/rex"
      '';
  });
in {
  imports = [inputs.rex.homeManagerModules.default];

  # On Linux, home-manager installs rex and runs the server. On macOS, the Rex
  # app provides both, so only the config file is shared.
  programs.rex = {
    enable = true;
    package =
      if isLinux
      then rexWithSkill
      else null;
    sshGuard = false;
    config = ./init.lua;
  };

  services.rex.enable = isLinux;

  programs.opencode.settings.skills = lib.mkIf isLinux ["${config.programs.rex.package}/share/skills"];
}
