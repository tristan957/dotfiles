{
  config,
  lib,
  ...
}: {
  options.modules.less.enable = lib.mkEnableOption "less";

  config = lib.mkIf config.modules.less.enable {
    programs.less = {
      enable = true;

      options = {
        RAW-CONTROL-CHARS = true;
        no-histdups = true;
        tabs = 4;
      };
    };

    home.sessionVariables = {
      LESSHISTSIZE = 1000000;
      LESSOPEN = "| pygmentize -O style=one-dark %s 2>/dev/null";
    };
  };
}
