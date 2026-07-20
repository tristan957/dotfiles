# Work-only MCP server definitions, alongside `dotfiles.lib.mcp.servers` for
# servers shared with the personal config. Takes `mkLocal` (from the dotfiles
# flake's `lib.mcp`) so definitions here get the same type checking.
{mkLocal}: {
  servers = {
    builder-mcp = mkLocal {
      name = "builder-mcp";
      command = "builder-mcp";
      env = {
        TOOL_PERSONALIZATION_ENABLED = "true";
        TOOL_PERSONALIZATION_MIN_EXECUTIONS = "0";
        TOOL_PERSONALIZATION_TRAINING_DAYS = "0";
        TOOL_PERSONALIZATION_ROLLOUT_PERCENTAGE = "100";
      };
    };
  };
}
