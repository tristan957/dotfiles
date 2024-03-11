function systemd_enable() {
    systemctl --user enable --now \
        desktop-database.service \
        desktop-database.path \
        mandb.service \
        mandb.path
}

function systemd_setup() {
    systemd_enable
}
