{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;

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
  programs.rex = lib.mkIf isLinux {
    enable = true;
    package = rexWithSkill;
    sshGuard = false;
    config = ./init.lua;
  };

  xdg.configFile."rex/init.lua" = lib.mkIf isDarwin {source = ./init.lua;};

  services.rex.enable = isLinux;

  programs.opencode.settings.skills = lib.mkIf isLinux ["${config.programs.rex.package}/share/skills"];
}
