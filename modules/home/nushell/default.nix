{...}: {
  config = {
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
      loadSessionVariables = true;
    };
  };
}
