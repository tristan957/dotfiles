function defaults_turn_off_press_and_hold {
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
}

function defaults_setup {
    defaults_turn_off_press_and_hold
}
