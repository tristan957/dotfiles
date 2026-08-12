{mcp, ...}: {
  programs.opencode.settings = {
    enabled_providers = ["amazon-bedrock"];

    mcp = mcp.opencode.generate [mcp.servers.builder-mcp];

    provider."amazon-bedrock".options = {
      region = "us-east-1";
      profile = "dbltap";
    };

    share = "disabled";
  };
}
