{
  config,
  dotfilesPackages,
  lib,
  pkgs,
  ...
}: let
  json = pkgs.formats.json {};

  # Render a `programs.mcp.servers` entry in Kiro's `mcpServers` shape
  # (https://kiro.dev/docs/mcp/configuration/): local servers use
  # `command`/`args`/`env`, remote servers use `url`/`headers`, and there is
  # no `type` key. Kiro loads servers by default and spells the override as
  # `disabled`, so that key is only emitted when a definition sets `enabled`.
  toKiro = name: server: let
    transformed = lib.hm.mcp.transformMcpServer {
      inherit server;
      # Kiro has no file-reference syntax, so file-backed env values are read
      # by a wrapper script instead.
      extraTransforms = [(lib.hm.mcp.wrapEnvFilesCommand {inherit pkgs name;})];
      exclude = ["enabled"];
    };
    enabled = lib.hm.mcp.resolveEnabled server;
  in
    transformed // lib.optionalAttrs (enabled != null) {disabled = !enabled;};
in {
  programs.toolbox.kiro.cli.enable = true;

  home.file = {
    ".kiro/skills".source = "${dotfilesPackages.skills}/skills";
    ".kiro/settings/mcp.json".source = json.generate "mcp.json" {
      mcpServers = lib.mapAttrs toKiro config.programs.mcp.servers;
    };
  };
}
