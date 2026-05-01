{config, ...}: {
  home.sessionVariables = {
    RUSTUP_HOME = "${config.home.homeDirectory}/.opt/rustup}";
  };
}
