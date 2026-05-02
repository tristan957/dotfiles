{
  config,
  lib,
  ...
}: {
  options.modules.nnn.enable = lib.mkEnableOption "nnn";

  config = lib.mkIf config.modules.nnn.enable {
    home.sessionVariables = {
      NNN_OPTS = "eEH";
    };
  };
}
