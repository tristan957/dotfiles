function aerc_permissions {
    chmod 600 "${XDG_CONFIG_HOME:-$HOME/.config}/aerc/accounts.conf"
}

function aerc_setup {
    aerc_permissions
}
