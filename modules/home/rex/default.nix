{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;

  rexExtended = inputs.rex.packages.${pkgs.stdenv.hostPlatform.system}.rex.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.installAgentSkills pkgs.installShellFiles];
    postInstall =
      (old.postInstall or "")
      + ''
        export HOME=$TMPDIR/home
        mkdir -p "$HOME"
        $out/bin/rex skill setup --agent opencode --autostart=false
        installSkill "$HOME/.agents/skills/rex"
        installShellCompletion --cmd rex \
          --bash <($out/bin/rex completion bash --autostart=false) \
          --zsh <($out/bin/rex completion zsh --autostart=false) \
          --fish <($out/bin/rex completion fish --autostart=false) \
          --nushell <($out/bin/rex completion nu --autostart=false)
        # installShellCompletion has no PowerShell support in current nixpkgs
        # pin. Waiting for the feature to move through the pipeline
        mkdir -p $out/share/powershell/completions
        $out/bin/rex completion powershell --autostart=false > $out/share/powershell/completions/rex.ps1
      '';
  });
in {
  imports = [inputs.rex.homeManagerModules.default];

  config = {
    programs.rex = {
      enable = true;
      package =
        if isLinux
        then rexExtended
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

    programs.opencode.settings.skills = lib.mkIf (config.programs.rex.package == rexExtended) ["${rexExtended}/share/skills"];
  };
}
