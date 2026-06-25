{
  config,
  lib,
  ...
}: {
  options.modules.less.enable = lib.mkEnableOption "less";

  config = lib.mkIf config.modules.less.enable {
    programs.less = {
      enable = true;

      config = ''
        #env
        LESSHISTSIZE = 1000000;
        LESSOPEN = | pygmentize -O style=one-dark %s 2>/dev/null;
      '';

      options = {
        RAW-CONTROL-CHARS = true;
        no-histdups = true;
        tabs = 4;
      };
    };
  };
}
