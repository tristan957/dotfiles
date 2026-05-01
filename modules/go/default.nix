{config, ...}: {
  home.sessionVariables = {
    GOBIN = "$HOME/.local/bin";
    GOMODCACHE = "${config.xdg.cacheHome}/go";
    GOPATH = "${config.xdg.dataHome}/go";
    # GOPROXY = "direct";
    GOTELEMETRY = "off";
  };
}
