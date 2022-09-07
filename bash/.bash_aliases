# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
alias ls="ls --indicator-style=slash --color=auto"

# Apply color to diff
alias diff="diff --color=auto"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# shellcheck disable=2139
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"

alias fold-email="cat <<EOF | fold --width 72 --spaces"
