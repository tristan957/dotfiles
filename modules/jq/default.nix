{
  config,
  lib,
  ...
}: {
  options.modules.jq.enable = lib.mkEnableOption "jq";

  config = lib.mkIf config.modules.jq.enable {
    home.sessionVariables = {
      JQ_COLORS = "0;33:0;33:0;33:0;33:0;32:0;39:0;39";
    };
  };
}
