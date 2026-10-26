{
  config,
  inputs,
  pkgs,
  ...
}: let
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

  programs.rex.enable = true;
  programs.rex.package = rexWithSkill;
  programs.rex.sshGuard = false;
  services.rex.enable = pkgs.stdenv.hostPlatform.isLinux;

  programs.opencode.settings.skills = ["${config.programs.rex.package}/share/skills"];
}
