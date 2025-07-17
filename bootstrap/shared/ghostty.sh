function ghostty_enable_service {
    systemctl --user enable --now app-com.mitchellh.ghostty.service
}

function ghostty_setup {
    ghostty_enable_service
}
