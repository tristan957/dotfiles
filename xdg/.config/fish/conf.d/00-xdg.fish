if ! set --query SYSTEMD_ENVIRONMENT_LOADED
    set -gx XDG_CACHE_HOME "$HOME/.cache"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx --path XDG_DATA_DIRS $XDG_DATA_DIRS
    contains -- $XDG_DATA_HOME $XDG_DATA_DIRS; or set -pgx XDG_DATA_DIRS $XDG_DATA_HOME
    set -gx XDG_STATE_HOME "$HOME/.local/state"
end
