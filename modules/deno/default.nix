{config, ...}: {
  config = {
    home.sessionVariables = {
      DENO_DIR = "${config.xdg.cacheHome}/deno";

      # An installation root, not a bin directory: `deno install -g` appends
      # /bin to it. Pointing it at xdg.binHome put binaries in a nested bin/
      # directory that is not on PATH.
      DENO_INSTALL_ROOT = builtins.dirOf config.xdg.binHome;

      DENO_REPL_HISTORY = "${config.xdg.stateHome}/deno/history";
    };
  };
}
