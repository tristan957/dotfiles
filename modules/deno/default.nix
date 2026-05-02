{
  config,
  lib,
  ...
}: {
  options.modules.deno.enable = lib.mkEnableOption "deno";

  config = lib.mkIf config.modules.deno.enable {
    home.sessionVariables = {
      DENO_DIR = "${config.xdg.cacheHome}/deno";
      DENO_INSTALL_ROOT = "${config.home.homeDirectory}/.local/bin";
      DENO_REPL_HISTORY = "${config.xdg.stateHome}/deno/history";
    };
  };
}
