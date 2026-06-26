{
  config,
  lib,
  ...
}: {
  config = {
    home.sessionVariables = {
      NODE_REPL_HISTORY = "${config.xdg.stateHome}/node/history";
    };

    home.activation.createNodeStateDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "${config.xdg.stateHome}/node"
    '';
  };
}
