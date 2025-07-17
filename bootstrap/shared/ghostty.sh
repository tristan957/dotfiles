function ghostty_enable_service {
    systemctl --user enable --now app-com.mitchellh.ghostty.service
}

function ghostty_setup {
    if command -v systemctl &>/dev/null; then
        ghostty_enable_service
    fi
}
