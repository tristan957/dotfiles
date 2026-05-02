{
  config,
  lib,
  ...
}: {
  options.modules.ripgrep.enable = lib.mkEnableOption "ripgrep";

  config = lib.mkIf config.modules.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
      arguments = ["--hidden"];
    };
  };
}
