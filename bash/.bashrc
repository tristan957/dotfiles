shopt -s checkwinsize
shopt -s failglob
shopt -s globstar
shopt -s histappend
shopt -s hostcomplete
shopt -s nullglob

if [ -z "$SYSTEMD_ENVIRONMENT_LOADED" ]; then
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    [[ ":$XDG_DATA_DIRS:" != *":$XDG_DATA_HOME:"* ]] && export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_DIRS"
    export XDG_STATE_HOME="$HOME/.local/state"
fi

# shellcheck disable=2034
IS_INTERACTIVE=$([[ $- == *i* ]] && echo 1 || echo 0)
# shellcheck disable=2034
IS_MACOS=$([[ "$(uname -s)" == Darwin ]] && echo 1 || echo 0)

# Source system bash files
. "/etc/bash.bashrc" 2>/dev/null
. "/etc/bashrc" 2>/dev/null

# Source all other bash config files
for f in "$XDG_CONFIG_HOME"/bash.d/*; do
    # shellcheck disable=1090
    . "$f"
done
