{
  config,
  lib,
  ...
}: {
  options.modules.dotnet.enable = lib.mkEnableOption "dotnet";

  config = lib.mkIf config.modules.dotnet.enable {
    home.sessionVariables = {
      NUGET_PACKAGES = "${config.xdg.cacheHome}/nuget";
    };
  };
}
