{...}: {
  config = {
    home.sessionVariables.PAGER = "less";

    programs.less = {
      enable = true;

      config = ''
        #env
        LESSHISTSIZE = 1000000;
      '';

      options = {
        RAW-CONTROL-CHARS = true;
        no-histdups = true;
        tabs = 4;
      };
    };
  };
}
