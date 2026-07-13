{
  programs.toolbox = {
    tools.ada.enable = true;

    ada = {
      enable = true;
      defaults = {
        Provider = "isengard";
        Region = "us-west-2";
      };
      profiles = {
        # To effectively use this account for things like OpenCode, I need to
        # set up user-agent strings per model. I'll just continue to use Bedrock
        # through my personal Isengard account.
        claude-code-DO-NOT-DELETE = {
          Account = "175342148895";
          Role = "CeceliaAmazonInternal";
        };
        dbltap = {
          Account = "534344665149";
        };
      };
    };
  };
}
