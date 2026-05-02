{
  config,
  lib,
  ...
}: {
  options.modules.testcontainers.enable = lib.mkEnableOption "testcontainers";

  config = lib.mkIf config.modules.testcontainers.enable {
    home.sessionVariables = {
      TESTCONTAINERS_RYUK_DISABLED = "true";
    };
  };
}
