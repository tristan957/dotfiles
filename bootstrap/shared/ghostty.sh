function ghostty_enable_service {
    systemctl --user enable --now com.mitchellh.ghostty.service
}

function ghostty_setup {
    ghostty_enable_service
}
