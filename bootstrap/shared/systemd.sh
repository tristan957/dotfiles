function systemd_enable() {
    systemd --user enable --now \
        mandb.service \
        mandb.path \
        tmux.service
}

function systemd_setup() {
    systemd_enable
}
