#!/usr/bin/env bash

set -e
set -o pipefail

for f in "$HOME/.bash"*; do
    # if we are a symlink, we most likely already stowed
    if [[ -L "$f" ]]; then
        continue
    else
        rm "$f"
    fi
done

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/postgresql/completions"
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions"
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/postgresql/completions"
mkdir -p "${XDG_STATE_HOME:-$HOME/.var}/postgresql"
mkdir -p "$HOME/.opt"

dir=$(dirname "${BASH_SOURCE[0]}")
. "$dir/shared/1password.sh"
. "$dir/shared/aerc.sh"
. "$dir/shared/asciinema.sh"
. "$dir/shared/bash-completion.sh"
. "$dir/shared/bitwarden.sh"
. "$dir/shared/deno.sh"
. "$dir/shared/desktop-database.sh"
. "$dir/shared/dconf.sh"
. "$dir/shared/docker.sh"
. "$dir/shared/flatpak.sh"
. "$dir/shared/gdb.sh"
. "$dir/shared/gh.sh"
. "$dir/shared/glab.sh"
. "$dir/shared/grub.sh"
. "$dir/shared/homebrew.sh"
. "$dir/shared/mandb.sh"
. "$dir/shared/podman.sh"
. "$dir/shared/rustup.sh"
. "$dir/shared/stow.sh"
. "$dir/shared/tmux.sh"
. "$dir/shared/uv.sh"

os=$(grep "^ID=" /etc/os-release | cut --delimiter="=" -f 2)
# shellcheck disable=SC1090
. "$dir/$os/distro.sh"

stow_setup
1password_setup
desktop_database_setup
mandb_setup
flatpak_setup
distro_setup
dconf_setup
# bitwarden_setup
gdb_setup
aerc_setup
deno_setup
rustup_setup
homebrew_setup
bash_completion_setup
tmux_setup
gh_setup
glab_setup
grub_setup
uv_setup
asciinema_setup
podman_setup
# docker_setup
