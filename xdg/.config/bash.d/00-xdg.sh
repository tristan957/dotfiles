if [[ $IS_MACOS -eq 1 ]]; then
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_DIRS"
    export XDG_STATE_HOME="$HOME/.var"
fi
