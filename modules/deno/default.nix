{config, ...}: {
  config = {
    home.sessionVariables = {
      DENO_DIR = "${config.xdg.cacheHome}/deno";
      DENO_INSTALL_ROOT = dirOf config.xdg.binHome;
      DENO_REPL_HISTORY = "${config.xdg.stateHome}/deno/history";
    };
  };
}
