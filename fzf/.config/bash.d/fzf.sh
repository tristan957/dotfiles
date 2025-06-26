export FZF_DEFAULT_OPTS_FILE="${XDG_CONFIG_HOME:=$HOME/.config}/fzf/fzfrc"

if [[ $IS_INTERACTIVE -eq 0 ]]; then
    return
fi

if command -v fzf &>/dev/null; then
    eval "$(fzf --bash 2>/dev/null)"
fi
