# pgflake

A Nix flake providing composable build dependencies for PostgreSQL development.
A goal for this flake would be to upstream it into Postgres someday, or maybe
move it into a more general location.

## Outputs

### `lib.mkPostgresDeps`

A function that returns a list of packages needed to build PostgreSQL, based on
a typed configuration attrset.

```nix
pgflake.lib.mkPostgresDeps {
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  config = {
    ssl = ["openssl"];
    icu = true;
    lz4 = true;
  };
}
```

### `devShells.<system>.default`

A development shell for working on this flake. Includes `alejandra`, `nixd`, and
`reuse`.

### `devShells.<system>.postgres`

A full-featured development shell with all PostgreSQL build dependencies and
developer tooling enabled.

### `checks.<system>.*`

Table-driven tests verifying that each config option includes/excludes the
correct packages. Run with:

```bash
nix flake check --no-build
```

## Configuration Options

### Build tooling (list — include any combination)

| Option | Type | Default | Values | Packages |
| -------- | ------ | --------- | -------- | ---------- |
| `buildBackend` | list of enum | `["ninja"]` | `ninja`, `samurai` | ninja, samurai |
| `buildSystem` | list of enum | `["meson"]` | `autoconf`, `meson`, `muon` | autoconf269, meson, muon |
| `cc` | list of enum | `["gcc"]` | `gcc`, `clang` | gcc, clang |
| `lineEditing` | list of enum | `[]` | `readline`, `libedit` | readline, libedit |
| `ssl` | list of enum | `[]` | `openssl`, `aws-lc`, `libressl` | openssl, aws-lc, libressl |

### Feature flags (boolean, default `false`)

| Option | Packages | Description |
| -------- | ---------- | ------------- |
| `curl` | curl | libcurl for OAuth 2.0 client flows |
| `docs` | ditaa, docbook2x, docbook_sgml_dtd_41, docbook_xsl, fop, pandoc | Documentation build toolchain |
| `gssapi` | krb5 | GSSAPI/Kerberos authentication |
| `icu` | icu | ICU collation support |
| `jit` | clang, llvm | LLVM-based JIT compilation |
| `ldap` | openldap | LDAP authentication and connection lookup |
| `lz4` | lz4 | LZ4 compression |
| `nls` | gettext | Native Language Support |
| `tap` | perlPackages.IPCRun | TAP test framework |
| `tcl` | tcl | PL/Tcl support |
| `uuid` | libuuid | UUID generation (e2fs backend) |
| `xml` | libxml2, libxslt | SQL/XML and XSLT support |
| `zlib` | zlib | zlib compression |
| `zstd` | zstd | Zstandard compression |

### Linux-only flags (boolean, default `false`)

| Option | Packages | Description |
| -------- | ---------- | ------------- |
| `bonjour` | avahi-compat | Bonjour/DNS-SD service discovery |
| `dtrace` | systemtap | DTrace/SystemTap dynamic tracing |
| `io_uring` | liburing | io_uring async I/O |
| `numa` | numactl | NUMA memory policy support |
| `pam` | linux-pam | PAM authentication |
| `selinux` | libselinux, libsepol, pcre2 | SELinux/sepgsql support |
| `systemd` | systemdLibs | systemd service notifications |
| `valgrind` | valgrind | Valgrind headers for memory instrumentation |

## Usage

### PostgreSQL devShell

```bash
nix develop .#postgres
```

### Flake development devShell

```bash
nix develop
```

### `direnv`

```bash
# .envrc
use flake path/to/pgflake#postgres
```

### Flake Dependency

```nix
{
  inputs.postgres.url = "git+https://git.sr.ht/~tristan957/dotfiles?dir=flakes/postgres";

  outputs = { self, nixpkgs, pgflake, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = postgres.lib.mkPostgresDeps {
          inherit pkgs;
          config = { ssl = ["openssl"]; icu = true; };
        };
      };
    };
}
```
