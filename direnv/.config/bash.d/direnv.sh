if [[ $IS_INTERACTIVE -eq 0 ]]; then
    return
fi

if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash 2>/dev/null)"
fi
