{pkgs}: {lib, ...}: {
  options = with lib;
    {
      buildBackend = mkOption {
        type = types.listOf (types.enum ["ninja" "samurai"]);
        default = ["ninja"];
      };
      buildSystem = mkOption {
        type = types.listOf (types.enum ["autoconf" "meson" "muon"]);
        default = ["meson"];
      };
      cc = mkOption {
        type = types.listOf (types.enum ["gcc" "clang"]);
        default = ["gcc"];
      };
      curl = mkOption {
        type = types.bool;
        default = false;
      };
      docs = mkOption {
        type = types.bool;
        default = false;
      };
      gssapi = mkOption {
        type = types.bool;
        default = false;
      };
      icu = mkOption {
        type = types.bool;
        default = false;
      };
      jit = mkOption {
        type = types.bool;
        default = false;
      };
      ldap = mkOption {
        type = types.bool;
        default = false;
      };
      lineEditing = mkOption {
        type = types.listOf (types.enum ["readline" "libedit"]);
        default = [];
      };
      lz4 = mkOption {
        type = types.bool;
        default = false;
      };
      nls = mkOption {
        type = types.bool;
        default = false;
      };
      ssl = mkOption {
        type = types.listOf (types.enum ["openssl" "aws-lc" "libressl"]);
        default = [];
      };
      tap = mkOption {
        type = types.bool;
        default = false;
      };
      tcl = mkOption {
        type = types.bool;
        default = false;
      };
      uuid = mkOption {
        type = types.bool;
        default = false;
      };
      xml = mkOption {
        type = types.bool;
        default = false;
      };
      zlib = mkOption {
        type = types.bool;
        default = false;
      };
      zstd = mkOption {
        type = types.bool;
        default = false;
      };
    }
    // lib.optionalAttrs pkgs.stdenv.isLinux {
      bonjour = mkOption {
        type = types.bool;
        default = false;
      };
      dtrace = mkOption {
        type = types.bool;
        default = false;
      };
      io_uring = mkOption {
        type = types.bool;
        default = false;
      };
      numa = mkOption {
        type = types.bool;
        default = false;
      };
      pam = mkOption {
        type = types.bool;
        default = false;
      };
      selinux = mkOption {
        type = types.bool;
        default = false;
      };
      systemd = mkOption {
        type = types.bool;
        default = false;
      };
      valgrind = mkOption {
        type = types.bool;
        default = false;
      };
    };
}
