function flatpak_add_remotes() {
    flatpak remote-add --if-not-exists --user flathub \
        https://flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists --user gnome-nightly \
        https://nightly.gnome.org/gnome-nightly.flatpakrepo
}

function flatpak_install_applications() {
    # Flathub
    flatpak install --user --assumeyes flathub \
        ch.protonmail.protonmail-bridge \
        com.belmoussaoui.Decoder \
        com.belmoussaoui.Obfuscate \
        com.bitwarden.desktop \
        com.discordapp.Discord \
        com.github.finefindus.eyedropper \
        com.mojang.Minecraft \
        com.rafaelmardojai.SharePreview \
        com.slack.Slack \
        com.spotify.Client \
        com.valvesoftware.Steam \
        de.haeckerfelix.Fragments \
        io.github.realmazharhussain.GdmSettings \
        org.gnome.design.Contrast \
        org.gnome.design.IconLibrary \
        org.gnome.design.Lorem \
        org.gnome.design.SymbolicPreview \
        org.signal.Signal \
        us.zoom.Zoom

    # GNOME Nightly
    flatpak install --user --assumeyes gnome-nightly \
        org.gnome.Adwaita1.Demo \
        org.gnome.Builder.Devel \
        org.gnome.Sdk.Debug//master \
        org.gtk.Demo4
}

function flatpak_setup() {
    flatpak_add_remotes
    flatpak_install_applications
}
