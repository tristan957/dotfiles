{
  config,
  lib,
  ...
}: {
  config = {
    home.sessionVariables.PAGER = "less";

    home.activation.createLessStateDir =
      lib.hm.dag.entryAfter ["writeBoundary"]
      # bash
      ''
        mkdir -p "${config.xdg.stateHome}/less"
      '';

    programs.less = {
      enable = true;

      config =
        # lesskey
        ''
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
