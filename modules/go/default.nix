{config, ...}: {
  config.programs.go = {
    enable = true;

    # Keep package null so go continues to come from rustup / the system.
    package = null;

    env = {
      GOBIN = "${config.home.homeDirectory}/.local/bin";
      GOMODCACHE = "${config.xdg.cacheHome}/go";
      GOPATH = "${config.xdg.dataHome}/go";
    };

    telemetry.mode = "off";
  };
}
