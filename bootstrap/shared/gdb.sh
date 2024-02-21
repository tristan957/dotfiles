function gdb_create_history() {
    mkdir -p "$XDG_STATE_HOME/gdb"
    touch "$XDG_STATE_HOME/gdb/history"
}

function gdb_setup() {
    gdb_create_history
}
