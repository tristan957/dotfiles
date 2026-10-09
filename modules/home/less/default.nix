{config, ...}: {
  config = {
    home.sessionVariables.PAGER = "less";

    home.activation.createLessStateDir =
      config.lib.activation.mkDir "${config.xdg.stateHome}/less";

    programs.less = {
      enable = true;

      config = ''
        #env
        LESSHISTFILE = ${config.xdg.stateHome}/less/history
        LESSHISTSIZE = 1000000
      '';

      options = {
        RAW-CONTROL-CHARS = true;
        no-histdups = true;
        tabs = 4;
      };
    };
  };
}
