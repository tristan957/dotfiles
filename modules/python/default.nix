{
  config,
  lib,
  ...
}: {
  config = {
    home.sessionVariables = {
      PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
      # Python virtual environments should stop messing with PS1
      VIRTUAL_ENV_DISABLE_PROMPT = 1;
    };

    home.activation.createPythonStateDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "${config.xdg.stateHome}/python"
    '';
  };
}
