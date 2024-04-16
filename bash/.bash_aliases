# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
alias ls="ls -v --indicator-style=slash --color=auto"

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

# shellcheck disable=2086,2139,2154,2183
alias colors='(x=$(tput op) y=$(printf %76s);for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} $(tput setaf $i;tput setab $i)${y// /=}$x;done)'

# Clear the current kubectl context
alias kubeclr="kubectl config unset current-context"

zz() {
    zoxide query --interactive "$1"
}
