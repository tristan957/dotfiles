{
  programs.opencode.settings = {
    enabled_providers = ["amazon-bedrock"];

    providers."amazon-bedrock".settings = {
      region = "us-east-1";
      profile = "dbltap";
    };

    share = "disabled";
  };
}
