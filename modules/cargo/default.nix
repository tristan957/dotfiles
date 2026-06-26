{config, ...}: {
  config = {
    home.sessionPath = [
      "$HOME/.opt/cargo/bin"
    ];

    home.sessionVariables = {
      CARGO_HOME = "${config.home.homeDirectory}/.opt/cargo";
      CARGO_INSTALL_ROOT = "${config.home.homeDirectory}/.local";
    };

    home.file.".opt/cargo/config.toml".source = ./config.toml;
  };
}
