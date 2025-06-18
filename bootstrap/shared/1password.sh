function 1password_enable_unit() {
    systemctl --user enable --now 1password.service
}

function 1password_setup() {
    if command -v systemctl &>/dev/null && command -v 1password &>/dev/null; then
        1password_enable_unit
    fi
}
