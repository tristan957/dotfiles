switch "$(uname)"
case Darwin
    set -gx XDG_CACHE_HOME "$HOME/.cache"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx XDG_DATA_DIRS "$XDG_DATA_HOME:$XDG_DATA_DIRS"
    set -gx XDG_STATE_HOME "$HOME/.var"
end
