{
  config,
  lib,
  ...
}: {
  options.modules.just.enable = lib.mkEnableOption "just";

  config = lib.mkIf config.modules.just.enable {
    xdg.configFile."just/justfile".source = ./justfile;
  };
}
