export FZF_DEFAULT_OPTS_FILE="${XDG_CONFIG_HOME:=$HOME/.config}/fzf/fzfrc"

if [[ $IS_INTERACTIVE -eq 0 ]]; then
    return
fi

if command -v fzf &>/dev/null; then
    if fzf --bash &>/dev/null; then
        eval "$(fzf --bash)"
    elif [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
        source /usr/share/doc/fzf/examples/key-bindings.bash
    fi
fi
