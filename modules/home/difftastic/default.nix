{
  config = {
    programs.difftastic = {
      enable = true;

      # https://difftastic.wilfred.me.uk/git.html
      git = {
        enable = true;
        mode = "difftool";
      };
    };

    programs.git.settings = {
      difftool.prompt = false;
      pager.difftool = true;
    };
  };
}
