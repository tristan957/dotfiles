{
  programs.toolbox = {
    tools.ada.enable = true;

    ada = {
      enable = true;
      defaults = {
        Provider = "isengard";
        Region = "us-west-2";
      };
      profiles.dbltap = {
        Account = "534344665149";
      };
    };
  };
}
