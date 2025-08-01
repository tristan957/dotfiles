function flatpak_add_remotes() {
    flatpak remote-add --if-not-exists --user flathub \
        https://flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists --user gnome-nightly \
        https://nightly.gnome.org/gnome-nightly.flatpakrepo
}

function flatpak_create_overrides() {
    # Electron applications and Wayland, smh
    flatpak override --user --socket=wayland com.discordapp.Discord
    flatpak override --user --socket=wayland com.slack.Slack
    flatpak override --user --socket=wayland md.obsidian.Obsidian
    flatpak override --user --env=SIGNAL_USE_WAYLAND=1 org.signal.Signal
}

function flatpak_install_applications() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    # Flathub
    xargs flatpak install --user --assumeyes flathub <<<"$(grep --extended-regexp --invert-match '^(#|$)' \
        "$dir/flatpak/flathub.txt")"

    # GNOME Nightly
    xargs flatpak install --user --assumeyes gnome-nightly <<<"$(grep --extended-regexp --invert-match '^(#|$)' \
        "$dir/flatpak/gnome-nightly.txt")"

    # Valent
    flatpak install --user --assumeyes --from https://valent.andyholmes.ca/valent.flatpakref
}

function flatpak_setup() {
    if [[ "$XDG_SESSION_TYPE" == tty ]]; then
        builtin return
    fi

    if ! command -v flatpak &>/dev/null; then
        builtin return
    fi

    flatpak_add_remotes
    flatpak_install_applications
    flatpak_create_overrides
}
