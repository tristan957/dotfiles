{config, ...}: {
  config = {
    home.sessionVariables = {
      GOBIN = "${config.home.homeDirectory}/.local/bin";
      GOMODCACHE = "${config.xdg.cacheHome}/go";
      GOPATH = "${config.xdg.dataHome}/go";
      # GOPROXY = "direct";
      GOTELEMETRY = "off";
    };
  };
}
