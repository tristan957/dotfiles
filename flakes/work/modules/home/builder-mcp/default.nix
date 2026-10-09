{...}: {
  programs.mcp = {
    enable = true;
    servers.builder-mcp = {
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
