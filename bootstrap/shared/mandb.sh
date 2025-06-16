function mandb_enable_unit() {
    systemctl --user enable --now mandb.path
}

function mandb_setup() {
    if command -v systemctl &>/dev/null; then
        mandb_enable_unit
    fi
}
