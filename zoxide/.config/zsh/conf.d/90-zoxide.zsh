export _ZO_ECHO=1

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh 2>/dev/null)"
fi
