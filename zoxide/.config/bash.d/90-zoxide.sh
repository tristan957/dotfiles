export _ZO_ECHO=1

if [[ $IS_INTERACTIVE -eq 0 ]]; then
    return
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash 2>/dev/null)"
fi
