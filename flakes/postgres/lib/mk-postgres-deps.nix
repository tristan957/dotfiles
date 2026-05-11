{configModule}: {
  pkgs,
  config ? {},
}: let
  lib = pkgs.lib;
  evaluated = lib.evalModules {
    modules = [(configModule {inherit pkgs;}) {config = config;}];
  };
  cfg = evaluated.config;
in
  with pkgs;
    [bison flex perl pkgconf python3]
    ++ lib.optionals (builtins.elem "gcc" cfg.cc) [gcc]
    ++ lib.optionals (builtins.elem "clang" cfg.cc) [clang]
    ++ lib.optionals (builtins.elem "autoconf" cfg.buildSystem) [autoconf269]
    ++ lib.optionals (builtins.elem "meson" cfg.buildSystem) [meson]
    ++ lib.optionals (builtins.elem "muon" cfg.buildSystem) [muon]
    ++ lib.optionals (builtins.elem "ninja" cfg.buildBackend) [ninja]
    ++ lib.optionals (builtins.elem "samurai" cfg.buildBackend) [samurai]
    ++ lib.optionals cfg.curl [curl]
    ++ lib.optionals cfg.docs [
      ditaa
      docbook2x
      docbook_sgml_dtd_41
      docbook_xsl
      graphviz
      fop
      pandoc
    ]
    ++ lib.optionals (cfg.bonjour or false) [avahi-compat]
    ++ lib.optionals (cfg.dtrace or false) [linuxPackages.systemtap]
    ++ lib.optionals cfg.gssapi [krb5]
    ++ lib.optionals cfg.icu [icu]
    ++ lib.optionals (cfg.io_uring or false) [liburing]
    ++ lib.optionals cfg.jit [clang llvm]
    ++ lib.optionals cfg.ldap [openldap]
    ++ lib.optionals (builtins.elem "readline" cfg.lineEditing) [readline]
    ++ lib.optionals (builtins.elem "libedit" cfg.lineEditing) [libedit]
    ++ lib.optionals cfg.lz4 [lz4]
    ++ lib.optionals cfg.nls [gettext]
    ++ lib.optionals (cfg.numa or false) [numactl]
    ++ lib.optionals (cfg.pam or false) [linux-pam]
    ++ lib.optionals (cfg.selinux or false) [libselinux libsepol pcre2]
    ++ lib.optionals (builtins.elem "openssl" cfg.ssl) [openssl]
    ++ lib.optionals (builtins.elem "aws-lc" cfg.ssl) [aws-lc]
    ++ lib.optionals (builtins.elem "libressl" cfg.ssl) [libressl]
    ++ lib.optionals (cfg.systemd or false) [systemdLibs]
    ++ lib.optionals (cfg.valgrind or false) [valgrind]
    ++ lib.optionals cfg.tap [perlPackages.IPCRun]
    ++ lib.optionals cfg.tcl [tcl]
    ++ lib.optionals cfg.uuid [libuuid]
    ++ lib.optionals cfg.xml [libxml2 libxslt]
    ++ lib.optionals cfg.zlib [zlib]
    ++ lib.optionals cfg.zstd [zstd]
