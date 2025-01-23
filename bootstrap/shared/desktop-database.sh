function desktop_database_enable_unit() {
    systemctl --user enable --now desktop-database.path
}

function desktop_database_setup() {
    desktop_database_enable_unit
}
