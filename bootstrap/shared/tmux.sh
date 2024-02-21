function tmux_create_history() {
    mkdir -p "$XDG_STATE_HOME/tmux"
    touch "$XDG_STATE_HOME/tmux/history"
}

function tmux_setup() {
    tmux_create_history
}
