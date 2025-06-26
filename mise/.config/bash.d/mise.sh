if [[ $IS_INTERACTIVE -eq 0 ]]; then
    return
fi

if command -v mise &>/dev/null; then
    eval "$(mise activate bash 2>/dev/null)"
fi
