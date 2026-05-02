{
  config,
  lib,
  ...
}: {
  options.modules.less.enable = lib.mkEnableOption "less";

  config = lib.mkIf config.modules.less.enable {
    home.sessionVariables = {
      LESS = "R";
      LESSHISTSIZE = 1000000;
      LESSOPEN = "| pygmentize -O style=one-dark %s 2>/dev/null";
    };
  };
}
