{
  config,
  lib,
  ...
}: let
  cfg = config.modules.aerc;
in {
  options.modules.aerc.symlink = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = ''
      Absolute path to symlink aerc's accounts.conf from for live editing
      (out-of-store symlink). Null installs a writable copy from the Nix store
      at activation. aerc refuses to launch unless accounts.conf is a writable
      0600 file, so it can never be a read-only Nix store symlink.
    '';
  };

  config = {
    xdg.configFile =
      {
        "aerc/aerc.conf".source = ./aerc.conf;
        "aerc/binds.conf".source = ./binds.conf;
        "aerc/filters".source = ./filters;
        "aerc/folder-maps".source = ./folder-maps;
        "aerc/signatures".source = ./signatures;
        "aerc/stylesets".source = ./stylesets;
      }
      // lib.optionalAttrs (cfg.symlink != null) {
        "aerc/accounts.conf".source =
          config.lib.file.mkOutOfStoreSymlink cfg.symlink;
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

    home.activation.aercAccounts = lib.hm.dag.entryAfter ["writeBoundary"] (
      if cfg.symlink != null
      then ''
        # Live checkout: ensure the symlinked accounts.conf is private.
        chmod 600 "${cfg.symlink}"
      ''
      else ''
        # No checkout: install a writable, private copy from the store.
        run install -Dm600 ${./accounts.conf} "${config.xdg.configHome}/aerc/accounts.conf"
      ''
    );
  };
}
