{config, ...}: {
  config = {
    programs.go.enable = true;
    programs.go.env = {
      GOBIN = "${config.xdg.binHome}";
      GOMODCACHE = "${config.xdg.cacheHome}/go";
      GOPATH = "${config.xdg.dataHome}/go";
    };
    programs.go.telemetry.mode = "off";
  };
}
