{
  config,
  lib,
  ...
}: {
  options.modules.cargo.enable = lib.mkEnableOption "cargo";

  config = lib.mkIf config.modules.cargo.enable {
    home.sessionVariables = {
      CARGO_HOME = "$HOME/.opt/cargo";
      CARGO_INSTALL_ROOT = "$HOME/.local";
    };

    home.sessionPath = [
      "$HOME/.opt/cargo/bin"
    ];

    home.file.".opt/cargo/config.toml".source = ./config.toml;
  };
}
