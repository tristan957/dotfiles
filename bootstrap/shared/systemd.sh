function systemd_enable() {
    systemctl --user enable --now \
        1password.service \
        desktop-database.path \
        mandb.path
}

function systemd_setup() {
    systemd_enable
}
