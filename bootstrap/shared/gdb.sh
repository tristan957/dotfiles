function gdb_setup() {
    mkdir -p "$XDG_CACHE_HOME/gdb"
    touch "$XDG_CACHE_HOME/gdb/history"
}
