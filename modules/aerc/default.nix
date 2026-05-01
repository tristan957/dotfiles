{
  config,
  lib,
  ...
}: {
  xdg.configFile = {
    "aerc/aerc.conf".source = ./aerc.conf;
    "aerc/binds.conf".source = ./binds.conf;
    "aerc/accounts.conf" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/modules/aerc/accounts.conf";
    };
    "aerc/filters".source = ./filters;
    "aerc/folder-maps".source = ./folder-maps;
    "aerc/signatures".source = ./signatures;
    "aerc/stylesets".source = ./stylesets;
  };

  home.file = {
    ".local/bin/aerc-notify" = {
      source = ./aerc-notify;
      executable = true;
    };
    ".local/bin/aerc-signature" = {
      source = ./aerc-signature;
      executable = true;
    };
  };

  home.activation.aercAccountsPermissions = lib.hm.dag.entryAfter ["writeBoundary"] ''
    chmod 600 "${config.home.homeDirectory}/dotfiles/modules/aerc/accounts.conf"
  '';
}
