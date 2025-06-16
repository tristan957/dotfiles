if [[ $IS_MACOS -eq 1 && -v GHOSTTY_RESOURCES_DIR ]]; then
    builtin source "$GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash"
fi
