{config, ...}: {
  config = {
    home.sessionVariables = {
      NODE_REPL_HISTORY = "${config.xdg.stateHome}/node/history";
    };

    home.activation.createNodeStateDir =
      config.lib.activation.mkDir "${config.xdg.stateHome}/node";
  };
}
