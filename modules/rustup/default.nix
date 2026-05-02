{
  config,
  lib,
  ...
}: {
  options.modules.rustup.enable = lib.mkEnableOption "rustup";

  config = lib.mkIf config.modules.rustup.enable {
    home.sessionVariables = {
      RUSTUP_HOME = "${config.home.homeDirectory}/.opt/rustup}";
    };
  };
}
