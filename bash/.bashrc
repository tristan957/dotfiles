IS_INTERACTIVE=$([[ $- == *i* ]] && echo 1 || echo 0)
IS_MACOS=$([[ "$(uname -s)" == 'Darwin' ]] && echo 1 || echo 0)

# Source all other bash config files
for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/bash.d/*; do
    # shellcheck disable=1090
    . "$f" 2>/dev/null
done

# Don't run if it's not an interactive shell
[[ $IS_INTERACTIVE -eq 0 ]] && builtin return

# Shell Options
shopt -s checkwinsize
shopt -s failglob
shopt -s globstar
shopt -s histappend
shopt -s hostcomplete

# Shell Settings

# shellcheck disable=SC2034
# GIT_COMPLETION_SHOW_ALL_COMMANDS=1
# shellcheck disable=SC2034
GIT_COMPLETION_SHOW_ALL=1
# shellcheck disable=SC2034
GIT_COMPLETION_IGNORE_CASE=1

HISTCONTROL='ignoredups:ignorespace'
HISTSIZE=1000000
HISTTIMEFORMAT='%FT%T%z: '

#-------------------------------------------------------------------------------

# Aliases/Functions

# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
alias ls='ls -v --hyperlink --indicator-style=slash --color=auto'

# Apply colors to commands
alias diff='diff --color=auto'

if ! command -v 'bw' &>/dev/null && command -v 'flatpak' &>/dev/null; then
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

if command -v 'rlwrap' &>/dev/null; then
    for cmd in dash luajit; do
        # shellcheck disable=2139
        alias $cmd="rlwrap $cmd"
    done
fi

if command -v 'run0' &>/dev/null; then
    alias run0='run0 --background'
fi

function 0x0() {
    curl -F "file=@$1" https://0x0.st
}

function tsh-kube-login() {
    tsh kube ls --format json | jq --raw-output '.[] | .kube_cluster_name' | fzf --bind 'enter:become(tsh kube login {})'
}

#-------------------------------------------------------------------------------

# System integration

. "/etc/bash.bashrc" 2>/dev/null
. "/etc/bashrc" 2>/dev/null

#-------------------------------------------------------------------------------

# fzf

if command -v 'fzf' &>/dev/null; then
    eval "$(fzf --bash 2>/dev/null)"
fi

#-------------------------------------------------------------------------------

# direnv

if command -v 'direnv' &>/dev/null; then
    eval "$(direnv hook bash 2>/dev/null)"
fi

#-------------------------------------------------------------------------------

# zoxide

if command -v 'zoxide' &>/dev/null; then
    eval "$(zoxide init bash 2>/dev/null)"
fi

#-------------------------------------------------------------------------------

# mise

if command -v 'mise' &>/dev/null; then
    eval "$(mise activate bash 2>/dev/null)"
fi

#-------------------------------------------------------------------------------

# nix

. "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.sh" 2>/dev/null

#-------------------------------------------------------------------------------

# Prompt

# How many directories to show
# PROMPT_DIRTRIM=1

# Add to shell history after every command
# PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# GIT_PS1_COMPRESSSPARSESTATE=1
# GIT_PS1_HIDE_IF_PWD_IGNORED=1
# GIT_PS1_OMITSPARSESTATE=1
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1
# shellcheck disable=SC2034
GIT_PS1_DESCRIBE_STYLE='branch'
# shellcheck disable=SC2034
GIT_PS1_SHOWCONFLICTSTATE='yes'
# shellcheck disable=SC2034
GIT_PS1_SHOWSTASHSTATE=1
# shellcheck disable=SC2034
GIT_PS1_SHOWUPSTREAM='verbose'
# shellcheck disable=SC2034
GIT_PS1_STATESEPARATOR=' '

# We sourced the script in the bash completion sourcing above for macOS
if [[ $IS_MACOS -eq 0 ]]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh 2>/dev/null
fi

have_git_ps1=$(command -v __git_ps1 &>/dev/null && echo 1 || echo 0)
have_kubectl=$(command -v kubectl &>/dev/null && echo 1 || echo 0)

function __tput() {
    tput "$@" 2>/dev/null
}

function __prompt_extras() {
    PROMPT_EXTRAS=''

    # Git information for prompt
    if git rev-parse --quiet &>/dev/null && [[ $have_git_ps1 -eq 1 ]]; then
        # shellcheck disable=SC2016
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(__git_ps1 "$(__tput setaf 39)[%s]")"
    fi

    # Python virtual environments are so fun
    if [[ -n ${VIRTUAL_ENV+x} ]]; then
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(__tput setaf 105)[$(basename "${VIRTUAL_ENV}")]"
    fi

    # kubectl current context/namespace
    if [[ $have_kubectl -eq 1 ]]; then
        kubectl_curr_ctx=$(kubectl config current-context 2>/dev/null)
        # shellcheck disable=SC2181
        if [[ $? -eq 0 ]]; then
            kubectl_curr_ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
            PROMPT_EXTRAS="${PROMPT_EXTRAS} $(__tput setaf 14)[$kubectl_curr_ctx > ${kubectl_curr_ns:-default}]"
        fi
    fi

    echo -ne "$PROMPT_EXTRAS"
}

# I could add the container application here:
#   - docker(container)
#   - podman(container)
#   - toolbox(container)
#   - distrobox(container)
#
# But the only time I should see my prompt in a container is with Toolbox or
# Distrobox, so should be all good.
function __prompt_host() {
    if [[ -n "$container" ]]; then
        sed -n 's/^name="\(.*\)"$/\1/p' </run/.containerenv
    else
        # Equivalent of \H
        hostname
    fi
}

PS1="\[$(__tput bold)\]\[$(__tput setaf 208)\][\$? \j \t] \[$(__tput setaf 76)\][\u@\$(__prompt_host)] \[$(__tput setaf 214)\][\W]\$(__prompt_extras)\[$(__tput sgr0)\]\n\[$(__tput bold)\]+ \$ \[$(__tput sgr0)\]"
PS2="\[$(__tput bold)\]> \[$(__tput sgr0)\]"
PS3="\[$(__tput bold)\]#? \[$(__tput sgr0)\]"
PS4='$(__tput sgr0)$(__tput bold)+ ${BASH_SOURCE:-}:${FUNCNAME[0]:-}:L${LINENO:-}:$(__tput sgr0)   '
