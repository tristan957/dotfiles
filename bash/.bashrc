# shellcheck disable=2034
IS_INTERACTIVE=$([[ $- == *i* ]] && echo 1 || echo 0)
# shellcheck disable=2034
IS_MACOS=$([[ "$(uname -s)" == Darwin ]] && echo 1 || echo 0)

# Source system bash files
. "/etc/bash.bashrc" 2>/dev/null
. "/etc/bashrc" 2>/dev/null

# Source all other bash config files
for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/bash.d/*; do
    # shellcheck disable=1090
    . "$f" 2>/dev/null
done
