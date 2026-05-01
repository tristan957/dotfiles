setopt numericglobsort

[ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
[ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"

# Source all other zsh config files
for f in "$XDG_CONFIG_HOME"/zsh/conf.d/*(N); do
    # shellcheck disable=1090
    . "$f"
done
