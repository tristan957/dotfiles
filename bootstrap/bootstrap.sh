#!/usr/bin/env bash

set -e
set -o pipefail

for f in "$HOME/.bash"*; do
    # if we are a symlink, we most likely already stowed
    if [ -h "$f" ]; then
        continue
    else
        rm "$f"
    fi
done
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions"
mkdir -p "$HOME/.opt"

dir=$(dirname "${BASH_SOURCE[0]}")
. "$dir/shared/1Password.sh"
. "$dir/shared/aerc.sh"
. "$dir/shared/bitwarden.sh"
. "$dir/shared/deno.sh"
. "$dir/shared/dconf.sh"
. "$dir/shared/flatpak.sh"
. "$dir/shared/gdb.sh"
. "$dir/shared/rustup.sh"
. "$dir/shared/stow.sh"

os=$(grep "^ID=" /etc/os-release | cut --delimiter="=" -f 2)
# shellcheck disable=SC1090
. "./$os/distro.sh"

flatpak_setup
distro_setup
dconf_setup
bitwarden_setup
1Password_setup
gdb_setup
stow_setup
aerc_setup
deno_setup
rustup_setup
