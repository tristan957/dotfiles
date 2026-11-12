{
  programs.git.includes = [
    {
      condition = "gitdir:~/Projects/work/";
      contents = {
        user.email = "dbltap@amazon.com";
        commit.template = "${./templates/work}";
        # Reset the personal credential helpers
        credential.helper = "";
        format.signatureFile = "${./signatures/work}";
      };
    }
  ];
}
