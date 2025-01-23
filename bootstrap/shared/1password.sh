function 1password_enable_unit() {
    systemctl --user enable --now 1password.service
}

function 1password_setup() {
    1password_enable_unit
}
