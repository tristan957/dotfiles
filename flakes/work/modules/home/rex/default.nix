{
  config,
  inputs,
  pkgs,
  ...
}: let
  rexSkill = pkgs.runCommand "rex-skill" {nativeBuildInputs = [config.programs.rex.package];} ''
    export HOME=$TMPDIR/home
    mkdir -p "$HOME"
    rex skill setup --agent opencode --autostart=false
    cp -r "$HOME/.agents/skills/rex" "$out"
  '';
in {
  imports = [inputs.rex.homeManagerModules.default];

  programs.rex.enable = true;
  programs.rex.sshGuard = false;
  services.rex.enable = pkgs.stdenv.hostPlatform.isLinux;

  home.file.".agents/skills/rex".source = rexSkill;
}
