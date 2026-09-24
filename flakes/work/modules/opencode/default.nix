{
  programs.opencode.settings = {
    enabled_providers = ["amazon-bedrock"];

    provider."amazon-bedrock".options = {
      region = "us-east-1";
      profile = "dbltap";
    };

    share = "disabled";
  };
}
