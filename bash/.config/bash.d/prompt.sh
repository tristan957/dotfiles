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
    . /usr/share/git-core/contrib/completion/git-prompt.sh 2>/dev/null
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
            kubectl_curr_ns=$(kubectl config view --minify \
                -o go-template='{{ if .contexts }}{{ with (index .contexts 0).context.namespace }}{{ . }}{{ else }}default{{ end }}{{ else }}default{{ end }}' \
                2>/dev/null)
            PROMPT_EXTRAS="${PROMPT_EXTRAS} $(__tput setaf 14)[$kubectl_curr_ctx > $kubectl_curr_ns]"
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
