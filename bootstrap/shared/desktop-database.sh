function desktop_database_enable_unit() {
    systemctl --user enable --now desktop-database.path
}

function desktop_database_setup() {
    if [[ $IS_MACOS -eq 1 ]]; then
        builtin return
    fi

    desktop_database_enable_unit
}
