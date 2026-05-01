{config, ...}: {
  home.sessionVariables = {
    NUGET_PACKAGES = "${config.xdg.cacheHome}/nuget";
  };
}
