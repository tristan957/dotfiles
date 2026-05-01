{
  config,
  lib,
  ...
}: {
  xdg.configFile = {
    "aerc/aerc.conf".source = ../aerc/.config/aerc/aerc.conf;
    "aerc/binds.conf".source = ../aerc/.config/aerc/binds.conf;
    "aerc/accounts.conf" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/aerc/.config/aerc/accounts.conf";
    };
    "aerc/filters".source = ../aerc/.config/aerc/filters;
    "aerc/folder-maps".source = ../aerc/.config/aerc/folder-maps;
    "aerc/signatures".source = ../aerc/.config/aerc/signatures;
    "aerc/stylesets".source = ../aerc/.config/aerc/stylesets;
  };

  home.file = {
    ".local/bin/aerc-notify" = {
      source = ../aerc/.local/bin/aerc-notify;
      executable = true;
    };
    ".local/bin/aerc-signature" = {
      source = ../aerc/.local/bin/aerc-signature;
      executable = true;
    };
  };

  home.activation.aercAccountsPermissions = lib.hm.dag.entryAfter ["writeBoundary"] ''
    chmod 600 "${config.home.homeDirectory}/dotfiles/aerc/.config/aerc/accounts.conf"
  '';
}
