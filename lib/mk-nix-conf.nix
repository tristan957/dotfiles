# Assemble nix.conf fragments into a single file and check that Nix accepts it.
#
#   mkNixConf pkgs [./a.conf ./b.conf]
#
# Fragments are concatenated in order. The result is meant to be installed as
# /etc/nix/nix.custom.conf (see scripts/install-nix-conf.sh).
#
# Nix exits non-zero for invalid values but only warns about settings it does
# not recognize, so the check also fails on "unknown setting" warnings.
pkgs: fragments:
pkgs.runCommand "nix.conf" {nativeBuildInputs = [pkgs.nix];} ''
  mkdir conf

  for fragment in ${builtins.concatStringsSep " " (map (f: "${f}") fragments)}; do
    cat "$fragment" >> conf/nix.conf
    echo >> conf/nix.conf
  done

  export HOME=$TMPDIR NIX_CONF_DIR=$PWD/conf NIX_USER_CONF_FILES=
  nix config show --extra-experimental-features nix-command >/dev/null 2>stderr || {
    cat stderr >&2
    exit 1
  }

  if grep --quiet 'unknown setting' stderr; then
    cat stderr >&2
    exit 1
  fi

  cp conf/nix.conf $out
''
