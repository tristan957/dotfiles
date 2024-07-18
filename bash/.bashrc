# Don't run if it's not an interactive shell
[[ $- != *i* ]] && return

# Ghostty bash shell integration support
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]] && [[ $SHLVL -gt 1 ]]; then
    # shellcheck disable=SC2034
    GHOSTTY_SHELL_INTEGRATION_NO_CURSOR=1
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash"
fi

# Shell Options
shopt -s checkwinsize
shopt -s failglob
shopt -s histappend
shopt -s hostcomplete
shopt -s globstar

#-------------------------------------------------------------------------------

# Bash Settings

source /usr/share/git-core/contrib/completion/git-prompt.sh 2>/dev/null
have_git_ps1=$(command -v __git_ps1 &>/dev/null; echo $?)

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
        GIT_PS1_SHOWUPSTREAM='verbose name'
        # shellcheck disable=SC2034
        GIT_PS1_STATESEPARATOR=' '
        # shellcheck disable=SC2016
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(__git_ps1 "$(tput setaf 39)[%s]")"
    fi

    # Python virtual environments are so fun
    if [[ -n ${VIRTUAL_ENV+x} ]]; then
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(tput setaf 105)[$(basename "${VIRTUAL_ENV}")]"
    fi

    # kubectl current context/namespace
    kubectl_curr_ctx=$(kubectl config current-context 2>/dev/null)
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        kubectl_curr_ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
        PROMPT_EXTRAS="${PROMPT_EXTRAS} $(tput setaf 14)[$kubectl_curr_ctx > ${kubectl_curr_ns:-default}]"
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
CONTAINER=$([[ -f /run/.containerenv ]]; echo $?)
function __prompt_host() {
    if [[ $CONTAINER -eq 0 ]]; then
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

HISTCONTROL='ignoredups:ignorespace'
HISTSIZE=1000000
HISTTIMEFORMAT='%FT%T%z: '

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

# Forget about "unable to sign commit" errors
export GPG_TTY=$(tty)

#-------------------------------------------------------------------------------

# Aliases/Functions

# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
alias ls='ls -v --indicator-style=slash --color=auto'

# Apply colors to commands
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# shellcheck disable=2139
alias wget="wget --hsts-file=${XDG_CACHE_HOME:-$HOME/.cache}/wget-hsts"

if ! command -v 'bw' >/dev/null 2>&1; then
    if flatpak list --app --columns=application | grep --quiet com.bitwarden.desktop &>/dev/null; then
        alias bw='flatpak run --command=bw com.bitwarden.desktop'
    fi
fi

# shellcheck disable=2086,2139,2154,2183
alias colors='(x=$(tput op) y=$(printf %76s);for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} $(tput setaf $i;tput setab $i)${y// /=}$x;done)'

# Clear the current kubectl context
alias kubeclr='kubectl config unset current-context'
alias kubens='kubectl config set-context --current --namespace'

# Shut the copyright notice up
alias gdb='gdb --quiet'
alias rust-gdb='rust-gdb --quiet'
alias bc='bc --quiet'

alias zz='zoxide query --interactive'

# Pull new history from the HISTFILE
alias hpull='history -r'
# Push new history to the HISTFILE
alias hpush='history -a'

#-------------------------------------------------------------------------------

# Bash Completion

if ! shopt -oq posix; then
    source /usr/share/bash-completion/bash_completion 2>/dev/null
    source /etc/bash_completion 2>/dev/null
fi

#-------------------------------------------------------------------------------

# fzf

eval "$(fzf --bash 2>/dev/null)"

#-------------------------------------------------------------------------------

# direnv

eval "$(direnv hook bash 2>/dev/null)"


#-------------------------------------------------------------------------------

# zoxide

eval "$(zoxide init bash 2>/dev/null)"
