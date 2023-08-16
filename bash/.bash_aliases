# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
alias ls="ls --indicator-style=slash --color=auto"

# Apply colors to commands
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# shellcheck disable=2139
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"

alias fold-email="cat <<EOF | fold --width 72 --spaces"

if ! type "bw" >/dev/null 2>&1; then
    if type "flatpak" >/dev/null 2>&1; then
        alias bw="flatpak run --command=bw com.bitwarden.desktop"
    fi
fi
