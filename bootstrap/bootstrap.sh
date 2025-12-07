#!/usr/bin/env bash

set -e
set -o pipefail

IS_MACOS=$([[ "$(uname -s)" == 'Darwin' ]] && echo 1 || echo 0)

for f in "$HOME/.bash"*; do
    # if we are a symlink, we most likely already stowed
    if [[ -L "$f" ]]; then
        continue
    else
        rm -rf "$f"
    fi
done

mkdir -p "$HOME/Projects"
mkdir -p "{$XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completion"
mkdir -p "${XDG_STATE_HOME:-$HOME/.var}"
mkdir -p "${XDG_STATE_HOME:-$HOME/.var}/postgresql"
mkdir -p "$HOME/.opt"

dir=$(dirname "${BASH_SOURCE[0]}")
. "$dir/shared/1password.sh"
. "$dir/shared/aerc.sh"
. "$dir/shared/asciinema.sh"
. "$dir/shared/desktop-database.sh"
. "$dir/shared/docker.sh"
. "$dir/shared/flatpak.sh"
. "$dir/shared/gdb.sh"
. "$dir/shared/gh.sh"
. "$dir/shared/ghostty.sh"
. "$dir/shared/glab.sh"
. "$dir/shared/grub.sh"
. "$dir/shared/homebrew.sh"
. "$dir/shared/mandb.sh"
. "$dir/shared/mise.sh"
. "$dir/shared/nix.sh"
. "$dir/shared/podman.sh"
. "$dir/shared/rustup.sh"
. "$dir/shared/stow.sh"
. "$dir/shared/tmux.sh"
. "$dir/shared/uv.sh"

if [[ $IS_MACOS -eq 1 ]]; then
    . "$dir/macos/system.sh"
else
    os=$(grep "^ID=" /etc/os-release | cut --delimiter="=" -f 2)
    # shellcheck disable=SC1090
    . "$dir/$os/system.sh"
fi

stow_setup

# Source all other bash config files
for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/bash.d/*; do
    # shellcheck disable=1090
    . "$f" 2>/dev/null
done

1password_setup
desktop_database_setup
mandb_setup
flatpak_setup
system_setup
gdb_setup
aerc_setup
rustup_setup
homebrew_setup
tmux_setup
gh_setup
ghostty_setup
glab_setup
grub_setup
uv_setup
asciinema_setup
podman_setup
# mise_setup
# nix_setup
# docker_setup
