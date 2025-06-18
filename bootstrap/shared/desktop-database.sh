function desktop_database_enable_unit() {
    systemctl --user enable --now desktop-database.path
}

function desktop_database_setup() {
    if [[ $IS_MACOS -eq 1 || "$XDG_SESSION_TYPE" == tty ]]; then
        builtin return
    fi

    if command -v systemctl &>/dev/null && command -v update-desktop-database &>/dev/null; then
        desktop_database_enable_unit
    fi
}
