function tmux_create_history() {
    mkdir -p "$XDG_STATE_HOME/tmux"
    touch "$XDG_STATE_HOME/tmux/history"
}

function tmux_setup_systemd() {
    systemctl --user enable --now \
        tmux-server.service \
        tmux-session.service
}

function tmux_setup() {
    tmux_create_history

    if command -v systemctl &>/dev/null; then
        tmux_setup_systemd
    fi
}
