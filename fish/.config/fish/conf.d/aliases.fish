if not status is-interactive
    return
end

# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
alias ls='ls -v --hyperlink --indicator-style=slash --color=auto'

# Apply colors to commands
alias diff='diff --color=auto'

if ! command --query 'bw' && command --query 'flatpak'
    if flatpak list --app --columns=application | grep --quiet com.bitwarden.desktop &>/dev/null
        alias bw='flatpak run --command=bw com.bitwarden.desktop'
    end
end

alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

# How to port this to fish
# alias colors='(x=$(tput op) y=$(printf %76s);for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} $(tput setaf $i;tput setab $i)${y// /=}$x;done)'

# Shut the copyright notice up
alias gdb='gdb --quiet'
alias rust-gdb='rust-gdb --quiet'
alias bc='bc --quiet'

alias zz='zoxide query --interactive'

# Pull new history
alias hpull='history merge'

if command --query 'rlwrap'
    for cmd in dash luajit
        alias $cmd="rlwrap $cmd"
    end
end

alias run0='run0 --background='
