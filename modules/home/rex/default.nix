{
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
          --nushell <($out/bin/rex completion nu --autostart=false) \
          --powershell <($out/bin/rex completion powershell --autostart=false)
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
    services.rex = lib.mkIf isLinux {
      enable = true;

      # Open links in the browser of the client that owns the terminal
      environment.BROWSER = lib.getExe (pkgs.writeShellScriptBin "rex-browser" ''
        exec ${lib.getExe rexExtended} open "$@"
      '');
    };

    programs.mcp.servers.superlogical.url = "https://www.superlogical.com/rex/community-mcp";

    programs.opencode.settings.skills = lib.mkIf isLinux ["${rexExtended}/share/skills"];
  };
}
