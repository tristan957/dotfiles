function aerc_enable_unit() {
    systemctl --user enable --now aerc-accounts-conf.path
}

function aerc_permissions() {
    chmod 600 "${XDG_CONFIG_HOME:-$HOME/.config}/aerc/accounts.conf"
}

function aerc_setup {
    aerc_permissions

    if command -v systemctl &>/dev/null; then
        aerc_enable_unit
    fi
}
