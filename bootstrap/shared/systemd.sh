function systemd_enable() {
    systemctl --user enable --now \
        mandb.service \
        mandb.path
}

function systemd_setup() {
    systemd_enable
}
