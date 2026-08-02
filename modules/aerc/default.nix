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
      ".local/libexec/aerc/hooks/mail-received" = config.lib.file.mkExecutable ./hooks/mail-received;
      "${config.xdg.binHome}/aerc-signature" = config.lib.file.mkExecutable ./aerc-signature;
    };
  };
}
