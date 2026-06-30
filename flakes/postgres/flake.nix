{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ {
    flake-parts,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      perSystem = {
        lib,
        pkgs,
        ...
      }: {
        devShells.default = pkgs.mkShell {
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
              meson
              muon
              ninja
              perl
              pkgconf
              python314
              samurai

              # Libraries
              # Postgres does not support aws-lc
              # aws-lc
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
              docbook_xml_dtd_45
              docbook_xsl
              fop
              graphviz
              pandoc

              # Testing
              perlPackages.IPCRun
              python314Packages.pytest

              # Dev tools
              basedpyright
              bash-language-server
              bear
              binutils
              ccache
              clang-tools
              cppcheck
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
              elfutils
              gcc16
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
      };
    };
}
