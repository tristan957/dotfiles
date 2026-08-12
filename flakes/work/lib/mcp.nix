# Work-only MCP server definitions, merged into the shared catalogue from the
# dotfiles flake's `lib.mcp`. Takes the whole shared lib rather than individual
# constructors so that definitions here get the same type checking, every
# constructor (including `mkRemote`) stays reachable, and consumers can use a
# single `mcp` value for both the server list and the per-tool generators.
{mcp}:
mcp
// {
  servers =
    mcp.servers
    // {
      builder-mcp = mcp.mkLocal {
        name = "builder-mcp";
        command = "builder-mcp";
        env = {
          TOOL_PERSONALIZATION_ENABLED = "true";
          TOOL_PERSONALIZATION_MIN_EXECUTIONS = "0";
          TOOL_PERSONALIZATION_TRAINING_DAYS = "0";
          TOOL_PERSONALIZATION_ROLLOUT_PERCENTAGE = "100";
        };
      };

      creds-agent = mcp.mkLocal {
        name = "creds-agent";
        command = "aim";
        args = ["mcp" "start-server" "local-creds-agent-mcp"];
      };
    };
}
