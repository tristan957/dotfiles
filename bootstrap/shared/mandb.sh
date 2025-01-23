function mandb_enable_unit() {
    systemctl --user enable --now mandb.path
}

function mandb_setup() {
    mandb_enable_unit
}
