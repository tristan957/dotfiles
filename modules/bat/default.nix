{
  config,
  lib,
  ...
}: {
  options.modules.bat.enable = lib.mkEnableOption "bat";

  config = lib.mkIf config.modules.bat.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "TwoDark";
      };
    };
  };
}
