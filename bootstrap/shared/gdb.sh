function gdb_create_history() {
    mkdir -p "${XDG_STATE_HOME:-$HOME/.var}/gdb"
    touch "${XDG_STATE_HOME:-$HOME/.var}/gdb/history"
}

function gdb_setup() {
    gdb_create_history
}
