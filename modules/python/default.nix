{config, ...}: {
  home.sessionVariables = {
    PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
    # Python virtual environments should stop messing with PS1
    VIRTUAL_ENV_DISABLE_PROMPT = 1;
  };
}
