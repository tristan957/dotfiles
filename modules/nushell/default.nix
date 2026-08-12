{...}: {
  config = {
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
    };
  };
}
