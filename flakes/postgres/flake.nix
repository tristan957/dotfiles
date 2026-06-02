{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {nixpkgs, ...}: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    devShells = forAllSystems ({pkgs}: {
      default = pkgs.mkShell {
        # _FORTIFY_SOURCE requires -O1+, conflicts with -O0 debug builds
        hardeningDisable = ["fortify"];

        # Nix's ICU package sets libdir in its .pc files to the -dev output, which
        # contains no .so files. Meson trusts that path, fails to find libicuuc.so,
        # and falls back to the system ICU (wrong version). Fix by providing .pc
        # files with libdir pointing to the actual library output.
        shellHook = ''
          export PKG_CONFIG_PATH="${
            pkgs.runCommand "icu-pc-fix" {} ''
              mkdir -p $out/lib/pkgconfig
              for pc in ${pkgs.icu.dev}/lib/pkgconfig/*.pc; do
                sed "s|libdir *=.*|libdir=${pkgs.icu}/lib|" "$pc" > "$out/lib/pkgconfig/$(basename "$pc")"
              done
            ''
          }/lib/pkgconfig''${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
        '';

        packages = with pkgs;
          [
            # Build dependencies
            autoconf269
            bison
            clang
            flex
            gcc
            meson
            muon
            ninja
            perl
            pkgconf
            python3
            samurai

            # Libraries
            aws-lc
            curl
            gettext
            icu
            krb5
            libedit
            libressl
            libxml2
            libxslt
            llvm
            lz4
            openldap
            openssl
            readline
            tcl
            libuuid
            zlib
            zstd

            # Docs
            ditaa
            docbook2x
            docbook_sgml_dtd_41
            docbook_xsl
            fop
            graphviz
            pandoc

            # Testing
            perlPackages.IPCRun

            # Dev tools
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
          ]
          ++ lib.optionals stdenv.isLinux [
            avahi-compat
            gdb
            libselinux
            libsepol
            liburing
            linux-pam
            linuxPackages.systemtap
            ltrace
            numactl
            pcre2
            perf
            rr
            strace
            systemdLibs
            valgrind
          ];
      };
    });
  };
}
