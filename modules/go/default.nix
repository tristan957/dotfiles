{
  config,
  lib,
  ...
}: {
  options.modules.go.enable = lib.mkEnableOption "go";

  config = lib.mkIf config.modules.go.enable {
    home.sessionVariables = {
      GOBIN = "$HOME/.local/bin";
      GOMODCACHE = "${config.xdg.cacheHome}/go";
      GOPATH = "${config.xdg.dataHome}/go";
      # GOPROXY = "direct";
      GOTELEMETRY = "off";
    };
  };
}
