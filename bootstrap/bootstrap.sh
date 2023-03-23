#!/usr/bin/env bash

. ./shared/deno.sh
. ./shared/flatpak.sh
. ./shared/gdb.sh
. ./shared/rustup.sh
. ./shared/stow.sh

os=$(grep "^ID=" /etc/os-release | cut --delimiter="=" -f 2)
# shellcheck disable=SC1090
. "./$os/distro.sh"

gdb_setup
stow_setup
deno_setup
flatpak_setup
rustup_setup
