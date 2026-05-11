{
  self,
  pkgs,
}:
pkgs.mkShell {
  packages =
    self.lib.mkPostgresDeps {
      inherit pkgs;
      config =
        {
          buildBackend = ["ninja" "samurai"];
          buildSystem = ["autoconf" "meson" "muon"];
          cc = ["gcc" "clang"];
          curl = true;
          docs = true;
          gssapi = true;
          icu = true;
          jit = true;
          ldap = true;
          lineEditing = ["readline" "libedit"];
          lz4 = true;
          nls = true;
          ssl = ["openssl" "aws-lc" "libressl"];
          tap = true;
          tcl = true;
          uuid = true;
          xml = true;
          zlib = true;
          zstd = true;
        }
        // pkgs.lib.optionalAttrs pkgs.stdenv.isLinux {
          bonjour = true;
          dtrace = true;
          io_uring = true;
          numa = true;
          pam = true;
          selinux = true;
          systemd = true;
          valgrind = true;
        };
    }
    ++ (with pkgs;
      [
        bash-language-server
        bear
        binutils
        ccache
        clang-tools
        cppcheck
        elfutils
        git
        include-what-you-use
        lcov
        lldb
        pgformatter
        postgres-language-server
        shellcheck
        universal-ctags
      ]
      ++ lib.optionals stdenv.isLinux [
        gdb
        ltrace
        perf
        rr
        strace
      ]);
}
