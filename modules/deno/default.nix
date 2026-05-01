{config, ...}: {
  home.sessionVariables = {
    DENO_DIR = "${config.xdg.cacheHome}/deno";
    DENO_INSTALL_ROOT = "${config.home.homeDirectory}/.local/bin";
    DENO_REPL_HISTORY = "${config.xdg.stateHome}/deno/history";
  };
}
