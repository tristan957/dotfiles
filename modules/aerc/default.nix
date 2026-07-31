{config, ...}: {
  config = {
    xdg.configFile = {
      "aerc/accounts.conf".source = ./accounts.conf;
      "aerc/aerc.conf".source = ./aerc.conf;
      "aerc/binds.conf".source = ./binds.conf;
      "aerc/filters".source = ./filters;
      "aerc/folder-maps".source = ./folder-maps;
      "aerc/signatures".source = ./signatures;
      "aerc/stylesets".source = ./stylesets;
    };

    home.file = {
      "${config.xdg.binHome}/aerc-notify" = config.lib.file.mkExecutable ./aerc-notify;
      "${config.xdg.binHome}/aerc-signature" = config.lib.file.mkExecutable ./aerc-signature;
    };
  };
}
