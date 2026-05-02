{
  config,
  lib,
  ...
}: {
  options.modules.rlwrap.enable = lib.mkEnableOption "rlwrap";

  config = lib.mkIf config.modules.rlwrap.enable {
    home.sessionVariables = {
      # I would love to keep history in XDG_STATE_HOME, but completions belong in
      # XDG_DATA_HOME.
      RLWRAP_HOME = "${config.xdg.dataHome}/rlwrap";
    };
  };
}
