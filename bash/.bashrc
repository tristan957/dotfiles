# Don't run if it's not an interactive shell
[[ $- != *i* ]] && return

# Shell Options
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar


BASH_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# Include some auxiliary files to keep this clean
source "$BASH_DIR/.bash_aliases"
source "$BASH_DIR/.bash_functions"

#-------------------------------------------------------------------------------

# Bash Settings

function __prompt_extras() {
    PROMPT_EXTRAS=""

    # Git information for prompt
    if git rev-parse >/dev/null 2>&1; then
        if [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
            source /usr/share/git-core/contrib/completion/git-prompt.sh
        fi

        # GIT_PS1_SHOWDIRTYSTATE=1
        # GIT_PS1_SHOWSTASHSTATE=1
        # GIT_PS1_SHOWUNTRACKEDFILES=1
        # GIT_PS1_HIDE_IF_PWD_IGNORED=1
        # GIT_PS1_STATESEPARATOR=" "
        # shellcheck disable=SC2034
        GIT_PS1_SHOWUPSTREAM="auto"
        # shellcheck disable=SC2034
        GIT_PS1_DESCRIBE_STYLE="auto"
        # shellcheck disable=SC2016
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(__git_ps1 "$(tput setaf 39)[%s]")"
    fi

    # Python virtual environments are so fun
    if [[ -n ${VIRTUAL_ENV+x} ]]; then
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(tput setaf 105)[$(basename "${VIRTUAL_ENV}")]"
    fi

    # kubectl current context/namespace
    if command -v "kubectl" >/dev/null 2>&1; then
        kubectl_curr_ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
        kubectl_curr_ctx=$(kubectl config current-context 2>/dev/null)
        # shellcheck disable=SC2181
        if [[ $? -eq 0 ]]; then
            PROMPT_EXTRAS="${PROMPT_EXTRAS} $(tput setaf 14)[${kubectl_curr_ns:-default} > $kubectl_curr_ctx]"
        fi
    fi

    echo -ne "$PROMPT_EXTRAS"
}

# I could add the container application here:
#   - docker(container)
#   - podman(container)
#   - toolbox(container)
#
# But the only time I should see my prompt in a container is with Toolbox or
# Distrobox, so should be all good.
function __prompt_host() {
    if [[ -f /run/.toolboxenv ]] || [[ -f /run/.distroboxenv ]]; then
        sed -n 's/^name="\(.*\)"$/\1/p' </run/.containerenv
    else
        # Equivalent of \H
        hostname
    fi
}

PS1="\[$(tput bold)\]\[$(tput setaf 208)\][\$? \j \t] \[$(tput setaf 76)\][\u@\$(__prompt_host)] \[$(tput setaf 214)\][\W]\$(__prompt_extras)\[$(tput sgr0)\]\n\[$(tput bold)\]+ \$ \[$(tput sgr0)\]"
PS2="\[$(tput bold)\]> \[$(tput sgr0)\]"
PS3="\[$(tput bold)\]#? \[$(tput sgr0)\]"
PS4='$(tput bold)+ ${BASH_SOURCE:-}:${FUNCNAME[0]:-}:L${LINENO:-}:$(tput sgr0)   '

# How many directories to show
# PROMPT_DIRTRIM=1

# Add to shell history after every command
# PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

HISTCONTROL="ignoredups:ignorespace"
HISTSIZE=1000000
HISTTIMEFORMAT="%FT%T%z: "

#-------------------------------------------------------------------------------

# Environment Variables

# Set default terminal text editor
if command -v "nvim" >/dev/null 2>&1; then
    export EDITOR="nvim"
    export GIT_EDITOR="nvim"
    export MANPAGER='nvim +Man!'
    export VISUAL="nvim"
elif command -v "vim" >/dev/null 2>&1; then
    export EDITOR="vim"
    export GIT_EDITOR="vim"
    export VISUAL="vim"
elif command -v "vi" >/dev/null 2>&1; then
    export EDITOR="vi"
    export GIT_EDITOR="vi"
    export VISUAL="vi"
else
    export EDITOR="nano"
    export GIT_EDITOR="nano"
    export VISUAL="nano"
fi

# Forget about "unable to sign commit" errors
export GPG_TTY=$(tty)

#-------------------------------------------------------------------------------

# Bash Completion

if ! shopt -oq posix; then
    source /usr/share/bash-completion/bash_completion 2>/dev/null
    source /etc/bash_completion 2>/dev/null
fi

#-------------------------------------------------------------------------------

# fzf

source /usr/share/fzf/shell/key-bindings.bash 2>/dev/null

#-------------------------------------------------------------------------------

# direnv

if command -v "direnv" >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

#-------------------------------------------------------------------------------

# zoxide

if command -v "zoxide" >/dev/null 2>&1; then
    export _ZO_ECHO=1
    eval "$(zoxide init bash)"
fi
