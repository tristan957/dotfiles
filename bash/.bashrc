builtin source "/etc/bashrc" 2>/dev/null
builtin source "$CARGO_HOME/env" 2>/dev/null

# Don't run if it's not an interactive shell
[[ $- != *i* ]] && return

BASH_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
DOTFILES_DIR=$(dirname "$BASH_DIR")

# Ghostty bash shell integration support
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
    # shellcheck disable=SC2034
    GHOSTTY_SHELL_INTEGRATION_NO_CURSOR=1
    # shellcheck disable=SC2034
    GHOSTTY_SHELL_INTEGRATION_NO_TITLE=1
    builtin source "$GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash"
fi

# Shell Options
shopt -s checkwinsize
shopt -s failglob
shopt -s globstar
shopt -s histappend
shopt -s hostcomplete

#-------------------------------------------------------------------------------

# Environment Variables

# Set default terminal text editor
if command -v 'nvim' >/dev/null 2>&1; then
    export EDITOR='nvim'
    export MANPAGER='nvim +Man!'
    export VISUAL='nvim'
elif command -v 'vim' >/dev/null 2>&1; then
    export EDITOR='vim'
    export VISUAL='vim'
elif command -v 'vi' >/dev/null 2>&1; then
    export EDITOR='vi'
    export VISUAL='vi'
else
    export EDITOR='nano'
    export VISUAL='nano'
fi

# Why would we be here?
#
# systemd now manages my environment variables, which is pretty great, minus
# some issues. One of these issues is that in an environment that isn't loaded
# by systemd, the environment variables aren't available. Here are some
# examples:
#   - Toolbx
#   - Distrobox
#
# So what can we do?
#
# Use a set of whitelisted environment variables from the systemd environment
# and import them here. Toolbx and Distrobox will import their own environment
# variables, so lets ignore those, and others.
if [[ "$SYSTEMD_USER_ENVIRONMENT_LOADED" -ne 1 ]]; then
    whitelisted_env="$(systemctl --user show-environment |
        grep --extended-regexp \
            "$(printf '^(%s)=' \
                "$(grep --extended-regexp --invert-match '^(#|$)' \
                    "$DOTFILES_DIR/systemd/whitelisted-env.conf" |
                    tr '\n' '|')")")"

    eval "$whitelisted_env"

    while IFS= read -r envvar; do
        export "$envvar=${!envvar}"
    done < <(cut -d= -f1 <<<"$whitelisted_env")
fi

#-------------------------------------------------------------------------------

# Bash Settings

source /usr/share/git-core/contrib/completion/git-prompt.sh 2>/dev/null
have_git_ps1=$(
    command -v __git_ps1 &>/dev/null
    echo $?
)

function __tput() {
    tput "$@" 2>/dev/null
}

function __prompt_extras() {
    PROMPT_EXTRAS=''

    # Git information for prompt
    if git rev-parse --quiet &>/dev/null && [[ $have_git_ps1 -eq 0 ]]; then
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
        # shellcheck disable=SC2016
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(__git_ps1 "$(__tput setaf 39)[%s]")"
    fi

    # Python virtual environments are so fun
    if [[ -n ${VIRTUAL_ENV+x} ]]; then
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(__tput setaf 105)[$(basename "${VIRTUAL_ENV}")]"
    fi

    # kubectl current context/namespace
    kubectl_curr_ctx=$(kubectl config current-context 2>/dev/null)
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        kubectl_curr_ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(__tput setaf 14)[$kubectl_curr_ctx > ${kubectl_curr_ns:-default}]"
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

# shellcheck disable=SC2034
# GIT_COMPLETION_SHOW_ALL_COMMANDS=1
# shellcheck disable=SC2034
GIT_COMPLETION_SHOW_ALL=1
# shellcheck disable=SC2034
GIT_COMPLETION_IGNORE_CASE=1

HISTCONTROL='ignoredups:ignorespace'
HISTSIZE=1000000
HISTTIMEFORMAT='%FT%T%z: '

# How many directories to show
# PROMPT_DIRTRIM=1

# Add to shell history after every command
# PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

#-------------------------------------------------------------------------------

# Aliases/Functions

# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
alias ls='ls -v --hyperlink --indicator-style=slash --color=auto'

# Apply colors to commands
alias diff='diff --color=auto'

# shellcheck disable=2139
alias wget="wget --hsts-file=${XDG_CACHE_HOME:-$HOME/.cache}/wget-hsts"

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

alias run0='run0 --background='

function 0x0() {
    curl -F "file=@$1" https://0x0.st
}

#-------------------------------------------------------------------------------

# fzf

eval "$(fzf --bash 2>/dev/null)"

#-------------------------------------------------------------------------------

# direnv

eval "$(direnv hook bash 2>/dev/null)"

#-------------------------------------------------------------------------------

# zoxide

eval "$(zoxide init bash 2>/dev/null)"
