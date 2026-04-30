function gdb_create_history() {
    mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/gdb"
    touch "${XDG_STATE_HOME:-$HOME/.local/state}/gdb/history"
}

function gdb_setup() {
    gdb_create_history
}
