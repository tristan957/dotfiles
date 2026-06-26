{config, ...}: {
  config.programs.go = {
    enable = true;

    # Keep package null so go continues to come from rustup / the system.
    package = null;

    env = {
      GOBIN = "${config.xdg.binHome}";
      GOMODCACHE = "${config.xdg.cacheHome}/go";
      GOPATH = "${config.xdg.dataHome}/go";
    };

    telemetry.mode = "off";
  };
}
