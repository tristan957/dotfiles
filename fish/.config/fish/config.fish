if ! set --query SYSTEMD_ENVIRONMENT_LOADED
    set -gx XDG_CACHE_HOME "$HOME/.cache"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx --path XDG_DATA_DIRS $XDG_DATA_HOME $XDG_DATA_DIRS
    set -gx XDG_STATE_HOME "$HOME/.var"
end

if not status is-interactive
    return
end

# Disable the default greeting
set -g fish_greeting
