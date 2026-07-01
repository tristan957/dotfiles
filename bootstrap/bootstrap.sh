#!/usr/bin/env bash

set -e
set -o pipefail

IS_MACOS=$([[ "$(uname -s)" == 'Darwin' ]] && echo 1 || echo 0)

for f in "$HOME/.bash"*; do
    # if we are a symlink, we most likely already set up home-manager
    if [[ -L "$f" ]]; then
        continue
    else
        rm -rf "$f"
    fi
done

mkdir -p "$HOME/Projects"
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/bash"
mkdir -p "$HOME/.opt"

dir=$(dirname "${BASH_SOURCE[0]}")
. "$dir/shared/asciinema.sh"
. "$dir/shared/docker.sh"
. "$dir/shared/flatpak.sh"
. "$dir/shared/glab.sh"
. "$dir/shared/grub.sh"
. "$dir/shared/homebrew.sh"
. "$dir/shared/podman.sh"

if [[ $IS_MACOS -eq 1 ]]; then
    . "$dir/macos/system.sh"
else
    os=$(grep "^ID=" /etc/os-release | cut --delimiter="=" -f 2 | sed 's/\"//g')
    # shellcheck disable=SC1090
    . "$dir/$os/system.sh"
fi

# Source all other bash config files
for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/bash.d/*; do
    # shellcheck disable=1090
    . "$f" 2>/dev/null
done

flatpak_setup
system_setup
homebrew_setup
glab_setup
grub_setup
asciinema_setup
podman_setup
# docker_setup
