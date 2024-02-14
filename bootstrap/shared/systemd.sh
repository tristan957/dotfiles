function systemd_enable() {
    systemd --user enable --now \
        mandb.service \
        mandb.timer \
        tmux.service
}

function systemd_setup() {
    systemd_enable
}
