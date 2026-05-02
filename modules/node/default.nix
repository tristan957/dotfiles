{
  config,
  lib,
  ...
}: {
  options.modules.node.enable = lib.mkEnableOption "node";

  config = lib.mkIf config.modules.node.enable {
    home.sessionVariables = {
      NODE_REPL_HISTORY = "${config.xdg.stateHome}/node/history";
    };
  };
}
