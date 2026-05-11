{
  self,
  forAllSystems,
}:
forAllSystems (
  {pkgs}: let
    names = deps: map (d: d.pname or d.name) deps;
    has = name: deps: builtins.elem name (names deps);
    mkDeps = config:
      self.lib.mkPostgresDeps {
        inherit pkgs;
        config = config;
      };

    cases = [
      {
        name = "backend-ninja";
        config = {buildBackend = ["ninja"];};
        expect = ["ninja"];
        reject = ["samurai"];
      }
      {
        name = "backend-samurai";
        config = {buildBackend = ["samurai"];};
        expect = ["samurai"];
        reject = ["ninja"];
      }
      {
        name = "backend-all";
        config = {buildBackend = ["ninja" "samurai"];};
        expect = ["ninja" "samurai"];
        reject = [];
      }
      {
        name = "bonjour-enabled";
        config = {bonjour = true;};
        expect = ["avahi-compat"];
        reject = [];
      }
      {
        name = "bonjour-disabled";
        config = {bonjour = false;};
        expect = [];
        reject = ["avahi-compat"];
      }
      {
        name = "build-autoconf";
        config = {buildSystem = ["autoconf"];};
        expect = ["autoconf"];
        reject = ["meson" "muon"];
      }
      {
        name = "build-meson";
        config = {buildSystem = ["meson"];};
        expect = ["meson"];
        reject = ["autoconf" "muon"];
      }
      {
        name = "build-muon";
        config = {buildSystem = ["muon"];};
        expect = ["muon"];
        reject = ["autoconf" "meson"];
      }
      {
        name = "build-all";
        config = {buildSystem = ["autoconf" "meson" "muon"];};
        expect = ["autoconf" "meson" "muon"];
        reject = [];
      }
      {
        name = "cc-clang";
        config = {cc = ["clang"];};
        expect = ["clang-wrapper"];
        reject = ["gcc-wrapper"];
      }
      {
        name = "cc-gcc";
        config = {cc = ["gcc"];};
        expect = ["gcc-wrapper"];
        reject = ["clang-wrapper"];
      }
      {
        name = "cc-both";
        config = {cc = ["gcc" "clang"];};
        expect = ["gcc-wrapper" "clang-wrapper"];
        reject = [];
      }
      {
        name = "curl-enabled";
        config = {curl = true;};
        expect = ["curl"];
        reject = [];
      }
      {
        name = "curl-disabled";
        config = {curl = false;};
        expect = [];
        reject = ["curl"];
      }
      {
        name = "docs-enabled";
        config = {docs = true;};
        expect = ["ditaa" "docbook2X" "docbook-sgml" "docbook-xsl-nons" "fop" "pandoc-cli"];
        reject = [];
      }
      {
        name = "docs-disabled";
        config = {docs = false;};
        expect = [];
        reject = ["ditaa" "docbook2X" "docbook-sgml" "docbook-xsl-nons" "fop" "pandoc-cli"];
      }
      {
        name = "dtrace-enabled";
        config = {dtrace = true;};
        expect = ["systemtap"];
        reject = [];
      }
      {
        name = "dtrace-disabled";
        config = {dtrace = false;};
        expect = [];
        reject = ["systemtap"];
      }
      {
        name = "gssapi-enabled";
        config = {gssapi = true;};
        expect = ["krb5"];
        reject = [];
      }
      {
        name = "gssapi-disabled";
        config = {gssapi = false;};
        expect = [];
        reject = ["krb5"];
      }
      {
        name = "icu-enabled";
        config = {icu = true;};
        expect = ["icu4c"];
        reject = [];
      }
      {
        name = "icu-disabled";
        config = {icu = false;};
        expect = [];
        reject = ["icu4c"];
      }
      {
        name = "io_uring-enabled";
        config = {io_uring = true;};
        expect = ["liburing"];
        reject = [];
      }
      {
        name = "io_uring-disabled";
        config = {io_uring = false;};
        expect = [];
        reject = ["liburing"];
      }
      {
        name = "jit-enabled";
        config = {jit = true;};
        expect = ["clang-wrapper" "llvm"];
        reject = [];
      }
      {
        name = "jit-includes-clang";
        config = {
          jit = true;
          cc = ["gcc"];
        };
        expect = ["llvm" "clang-wrapper"];
        reject = [];
      }
      {
        name = "jit-disabled";
        config = {jit = false;};
        expect = [];
        reject = ["llvm"];
      }
      {
        name = "ldap-enabled";
        config = {ldap = true;};
        expect = ["openldap"];
        reject = [];
      }
      {
        name = "ldap-disabled";
        config = {ldap = false;};
        expect = [];
        reject = ["openldap"];
      }
      {
        name = "line-readline";
        config = {lineEditing = ["readline"];};
        expect = ["readline"];
        reject = ["libedit"];
      }
      {
        name = "line-libedit";
        config = {lineEditing = ["libedit"];};
        expect = ["libedit"];
        reject = ["readline"];
      }
      {
        name = "line-both";
        config = {lineEditing = ["readline" "libedit"];};
        expect = ["readline" "libedit"];
        reject = [];
      }
      {
        name = "line-none";
        config = {lineEditing = [];};
        expect = [];
        reject = ["readline" "libedit"];
      }
      {
        name = "lz4-enabled";
        config = {lz4 = true;};
        expect = ["lz4"];
        reject = [];
      }
      {
        name = "lz4-disabled";
        config = {lz4 = false;};
        expect = [];
        reject = ["lz4"];
      }
      {
        name = "nls-enabled";
        config = {nls = true;};
        expect = ["gettext"];
        reject = [];
      }
      {
        name = "nls-disabled";
        config = {nls = false;};
        expect = [];
        reject = ["gettext"];
      }
      {
        name = "numa-enabled";
        config = {numa = true;};
        expect = ["numactl"];
        reject = [];
      }
      {
        name = "numa-disabled";
        config = {numa = false;};
        expect = [];
        reject = ["numactl"];
      }
      {
        name = "pam-enabled";
        config = {pam = true;};
        expect = ["linux-pam"];
        reject = [];
      }
      {
        name = "pam-disabled";
        config = {pam = false;};
        expect = [];
        reject = ["linux-pam"];
      }
      {
        name = "selinux-enabled";
        config = {selinux = true;};
        expect = ["libselinux"];
        reject = [];
      }
      {
        name = "selinux-disabled";
        config = {selinux = false;};
        expect = [];
        reject = ["libselinux"];
      }
      {
        name = "ssl-aws-lc";
        config = {ssl = ["aws-lc"];};
        expect = ["aws-lc"];
        reject = ["openssl" "libressl"];
      }
      {
        name = "ssl-disabled";
        config = {ssl = [];};
        expect = [];
        reject = ["openssl" "aws-lc" "libressl"];
      }
      {
        name = "ssl-libressl";
        config = {ssl = ["libressl"];};
        expect = ["libressl"];
        reject = ["openssl" "aws-lc"];
      }
      {
        name = "ssl-openssl";
        config = {ssl = ["openssl"];};
        expect = ["openssl"];
        reject = ["aws-lc" "libressl"];
      }
      {
        name = "ssl-all";
        config = {ssl = ["openssl" "aws-lc" "libressl"];};
        expect = ["openssl" "aws-lc" "libressl"];
        reject = [];
      }
      {
        name = "systemd-enabled";
        config = {systemd = true;};
        expect = ["systemd-minimal-libs"];
        reject = [];
      }
      {
        name = "systemd-disabled";
        config = {systemd = false;};
        expect = [];
        reject = ["systemd-minimal-libs"];
      }
      {
        name = "tap-enabled";
        config = {tap = true;};
        expect = ["IPC-Run"];
        reject = [];
      }
      {
        name = "tap-disabled";
        config = {tap = false;};
        expect = [];
        reject = ["IPC-Run"];
      }
      {
        name = "tcl-enabled";
        config = {tcl = true;};
        expect = ["tcl"];
        reject = [];
      }
      {
        name = "tcl-disabled";
        config = {tcl = false;};
        expect = [];
        reject = ["tcl"];
      }
      {
        name = "uuid-enabled";
        config = {uuid = true;};
        expect = ["util-linux-minimal"];
        reject = [];
      }
      {
        name = "uuid-disabled";
        config = {uuid = false;};
        expect = [];
        reject = ["util-linux-minimal"];
      }
      {
        name = "valgrind-enabled";
        config = {valgrind = true;};
        expect = ["valgrind"];
        reject = [];
      }
      {
        name = "valgrind-disabled";
        config = {valgrind = false;};
        expect = [];
        reject = ["valgrind"];
      }
      {
        name = "xml-enabled";
        config = {xml = true;};
        expect = ["libxml2" "libxslt"];
        reject = [];
      }
      {
        name = "xml-disabled";
        config = {xml = false;};
        expect = [];
        reject = ["libxml2" "libxslt"];
      }
      {
        name = "zlib-enabled";
        config = {zlib = true;};
        expect = ["zlib"];
        reject = [];
      }
      {
        name = "zlib-disabled";
        config = {zlib = false;};
        expect = [];
        reject = ["zlib"];
      }
      {
        name = "zstd-enabled";
        config = {zstd = true;};
        expect = ["zstd"];
        reject = [];
      }
      {
        name = "zstd-disabled";
        config = {zstd = false;};
        expect = [];
        reject = ["zstd"];
      }
    ];

    mkCheck = {
      name,
      config,
      expect,
      reject,
    }: let
      deps = mkDeps config;
    in
      pkgs.runCommand "pgflake-check-${name}" {} ''
        ${builtins.concatStringsSep "\n" (
          map (p: assert has p deps; "") expect
          ++ map (p: assert !(has p deps); "") reject
        )}
        echo "${name}: PASS" && touch $out
      '';
  in
    builtins.listToAttrs (map (c: {
        name = c.name;
        value = mkCheck c;
      })
      cases)
)
