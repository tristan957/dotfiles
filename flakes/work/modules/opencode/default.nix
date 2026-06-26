{
  programs.opencode.settings = {
    mcp.builder-mcp = {
      enabled = false;
      type = "local";
      command = ["builder-mcp"];
      env = {
        TOOL_PERSONALIZATION_ENABLED = "true";
        TOOL_PERSONALIZATION_MIN_EXECUTIONS = "0";
        TOOL_PERSONALIZATION_TRAINING_DAYS = "0";
        TOOL_PERSONALIZATION_ROLLOUT_PERCENTAGE = "100";
      };
    };

    provider."amazon-bedrock".options = {
      region = "us-east-1";
      profile = "dbltap";
    };
  };
}
