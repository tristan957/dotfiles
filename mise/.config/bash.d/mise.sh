if [[ $IS_INTERACTIVE -eq 0 ]]; then
    return
fi

export MISE_LOG_FILE "$XDG_STATE_HOME/mise/mise.log"

if command -v mise &>/dev/null; then
    eval "$(mise activate bash 2>/dev/null)"
fi
