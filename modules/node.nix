{config, ...}: {
  home.sessionVariables = {
    NODE_REPL_HISTORY = "${config.xdg.stateHome}/node/history";
  };
}
