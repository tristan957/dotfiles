{
  pkgs,
  lib,
  ...
}: let
  json = pkgs.formats.json {};
in {
  programs.toolbox.kiro.cli.enable = true;

  home.activation.kiroMcpConfig =
    lib.hm.dag.entryAfter ["writeBoundary"]
    # bash
    ''
      install -Dm644 ${json.generate "mcp.json" {
        mcpServers = {
          builder-mcp = {
            command = "builder-mcp";
            args = [];
            env = {
              TOOL_PERSONALIZATION_ENABLED = "true";
              TOOL_PERSONALIZATION_MIN_EXECUTIONS = 0;
              TOOL_PERSONALIZATION_TRAINING_DAYS = 0;
              TOOL_PERSONALIZATION_ROLLOUT_PERCENTAGE = 100;
            };
          };
          m365-mcp = {
            command = "grasp-mcp";
            args = [];
          };
        };
      }} "$HOME/.kiro/settings/mcp.json"
    '';
}
