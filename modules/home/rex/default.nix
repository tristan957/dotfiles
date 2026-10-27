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

  config = {
    programs.rex = {
      enable = true;
      package =
        if isLinux
        then rexWithSkill
        else null;
      sshGuard = false;
      # The config is for the app, which is macOS only at the moment
      config =
        if isDarwin
        then ./init.lua
        else null;
    };

    # The server is distributed on macOS via the app
    services.rex.enable = isLinux;

    programs.mcp.servers.superlogical.url = "https://www.superlogical.com/rex/community-mcp";

    programs.opencode.settings.skills = lib.mkIf (config.programs.rex.package == rexWithSkill) ["${rexWithSkill}/share/skills"];
  };
}
