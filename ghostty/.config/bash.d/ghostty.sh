if [[ $IS_MACOS -eq 1 && -v GHOSTTY_RESOURCES_DIR ]]; then
    GHOSTTY_RESOURCES_DIR_PARENT="$(dirname "$GHOSTTY_RESOURCES_DIR")"
    . "$GHOSTTY_RESOURCES_DIR_PARENT/bash-completion/completions/ghostty.bash"
fi
