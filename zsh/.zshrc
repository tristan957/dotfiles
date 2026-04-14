if [ -z "$SYSTEMD_ENVIRONMENT_LOADED" ]; then
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    [[ ":$XDG_DATA_DIRS:" != *":$XDG_DATA_HOME:"* ]] && export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_DIRS"
    export XDG_STATE_HOME="$HOME/.var"
fi

setopt numericglobsort

[ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
[ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"

# Source all other zsh config files
for f in "$XDG_CONFIG_HOME"/zsh/conf.d/*(N); do
    # shellcheck disable=1090
    . "$f"
done
