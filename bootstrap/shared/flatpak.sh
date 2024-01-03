function flatpak_add_remotes() {
    flatpak remote-add --if-not-exists --user flathub \
        https://flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists --user gnome-nightly \
        https://nightly.gnome.org/gnome-nightly.flatpakrepo
}

function flatpak_install_applications() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    # Flathub
    xargs flatpak install --user --assumeyes flathub <"$dir/flatpak/flathub.txt"

    # GNOME Nightly
    xargs flatpak install --user --assumeyes gnome-nightly <"$dir/flatpak/gnome-nightly.txt"

    # Valent
    flatpak install --user --from https://valent.andyholmes.ca/valent.flatpakref
}

function flatpak_setup() {
    flatpak_add_remotes
    flatpak_install_applications
}
