#!/usr/bin/env bash

mkdir -p "$XDG_DATA_HOME/bash-completion/completions"

dir=$(dirname "${BASH_SOURCE[0]}")
. "$dir/shared/bitwarden.sh"
. "$dir/shared/deno.sh"
. "$dir/shared/flatpak.sh"
. "$dir/shared/gdb.sh"
. "$dir/shared/rustup.sh"
. "$dir/shared/stow.sh"

os=$(grep "^ID=" /etc/os-release | cut --delimiter="=" -f 2)
# shellcheck disable=SC1090
. "./$os/distro.sh"

flatpak_setup
distro_setup
bitwarden_login
gdb_setup
stow_setup
deno_setup
rustup_setup
