# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
alias ls='ls -v --hyperlink --indicator-style=slash --color=auto'

# Apply colors to commands
alias diff='diff --color=auto'

if ! command -v bw &>/dev/null && command -v flatpak &>/dev/null; then
    if flatpak list --app --columns=application | grep --quiet 'com.bitwarden.desktop' &>/dev/null; then
        alias bw='flatpak run --command=bw com.bitwarden.desktop'
    fi
fi

# shellcheck disable=2086,2139,2154,2183
alias colors='(x=$(tput op) y=$(printf %76s);for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} $(tput setaf $i;tput setab $i)${y// /=}$x;done)'

# Shut the copyright notice up
alias gdb='gdb --quiet'
alias rust-gdb='rust-gdb --quiet'
alias bc='bc --quiet'

alias zz='zoxide query --interactive'

# Pull new history from the HISTFILE
alias hpull='history -r'
# Push new history to the HISTFILE
alias hpush='history -a'

if command -v rlwrap &>/dev/null; then
    for cmd in dash luajit; do
        # shellcheck disable=2139
        alias $cmd="rlwrap $cmd"
    done
fi

if command -v run0 &>/dev/null; then
    alias run0='run0 --background'
fi

function 0x0() {
    curl -F "file=@$1" https://0x0.st
}

function tsh-kube-login() {
    tsh kube ls --format json | jq --raw-output '.[] | .kube_cluster_name' | fzf --bind 'enter:become(tsh kube login {})'
}
