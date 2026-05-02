{
  config,
  lib,
  ...
}: {
  options.modules.kiro.enable = lib.mkEnableOption "kiro";

  config = lib.mkIf config.modules.kiro.enable {
    home.file.".kiro/skills".source = ../../skills;
  };
}
