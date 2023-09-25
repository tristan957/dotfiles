# I am not really sure if this is the best place for the interactive check, but
# at least it stops gnome-shell from segfaulting due to the XDG_CONFIG_DIRS code
# later in this file.
[[ $- != *i* ]] && return

# Shell Options
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# Add to shell history after every command
# PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

BASH_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# Include some auxiliary files to keep this clean
. "${BASH_DIR}/.bash_aliases"
. "${BASH_DIR}/.bash_functions"

#-------------------------------------------------------------------------------

# Prompt

function __prompt_extras() {
    PROMPT_EXTRAS=""

    # Git information for prompt
    if git rev-parse >/dev/null 2>&1; then
        . "${BASH_DIR}/git-prompt.sh"
        # GIT_PS1_SHOWDIRTYSTATE=1
        # GIT_PS1_SHOWSTASHSTATE=1
        # GIT_PS1_SHOWUNTRACKEDFILES=1
        GIT_PS1_SHOWUPSTREAM="auto"
        GIT_PS1_DESCRIBE_STYLE="auto"
        # GIT_PS1_HIDE_IF_PWD_IGNORED=1
        # GIT_PS1_STATESEPARATOR=" "
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

PS1="\[$(tput bold)\]\[$(tput setaf 208)\][\$? \j \t] \[$(tput setaf 76)\][\u@\H] \[$(tput setaf 214)\][\W]\$(__prompt_extras)\[$(tput sgr0)\]\n\[$(tput bold)\]+ \$ \[$(tput sgr0)\]"
PS2="\[$(tput bold)\]> \[$(tput sgr0)\]"
PS3="\[$(tput bold)\]#? \[$(tput sgr0)\]"
PS4="\[$(tput bold)\]+ \[$(tput sgr0)\]"

# How many directories to show
# PROMPT_DIRTRIM=1

#-------------------------------------------------------------------------------

# Environment Variables

# Nix, stop it
export NIX_INSTALLER_NO_MODIFY_PROFILE=1

# nnn options
export NNN_OPTS="eEH"

export LS_COLORS="${LS_COLORS}:di=1:ex=4:ow=1:"

# XDG User Directories
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.var"
export XDG_DESKTOP_DIR="${HOME}/Desktop"
export XDG_DOCUMENTS_DIR="${HOME}/Documents"
export XDG_DOWNLOAD_DIR="${HOME}/Downloads"
export XDG_MUSIC_DIR="${HOME}/Music"
export XDG_PICTURES_DIR="${HOME}/Pictures"
export XDG_PUBLICSHARE_DIR="${HOME}/Public"
export XDG_TEMPLATES_DIR="${HOME}/Templates"
export XDG_VIDEOS_DIR="${HOME}/Videos"

# $XDG_RUNTIME_DIR defines the base directory relative to which user-specific
# non-essential runtime files and other file objects (such as sockets, named
# pipes, ...) should be stored. The directory MUST be owned by the user, and
# he MUST be the only one having read and write access to it. Its Unix access
# mode MUST be 0700.
if [ -z "${XDG_RUNTIME_DIR}" ]; then
    export XDG_RUNTIME_DIR="/run/user/${UID}"

    if [ ! -d $XDG_RUNTIME_DIR ]; then
        mkdir $XDG_RUNTIME_DIR
    fi
fi
if [[ $(stat -c '%a' "$XDG_RUNTIME_DIR") != "700" ]]; then
    chmod 0700 "$XDG_RUNTIME_DIR"
fi

if [ -z "${XDG_CONFIG_DIRS}" ]; then
    export XDG_CONFIG_DIRS="${XDG_CONFIG_HOME}:/etc"
else
    if [[ "${XDG_CONFIG_DIRS}" != *"${XDG_CONFIG_HOME}"* ]]; then
        export XDG_CONFIG_DIRS="${XDG_CONFIG_HOME}:${XDG_CONFIG_DIRS}"
    fi
fi

if [ -z "${XDG_DATA_DIRS}" ]; then
    export XDG_DATA_DIRS="${XDG_DATA_HOME}:${XDG_DATA_DIRS}"
else
    # ending ':' because of Flatpak local exports in ~/.local/share/flaptak/exports/share
    if [[ "${XDG_DATA_DIRS}" != *"${XDG_DATA_HOME}:"* ]]; then
        export XDG_DATA_DIRS="${XDG_DATA_HOME}:${XDG_DATA_DIRS}"
    fi
fi

# I hate software that thinks it is special.
# https://wiki.archlinux.org/title/XDG_Base_Directory
export GDBHISTFILE="${XDG_CACHE_HOME}/gdb/history"
# ipython can die in a hole for this: https://github.com/ipython/ipython/pull/4457
export IPYTHONDIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${TERMINFO}:/usr/share/terminfo"
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"
if [ -f "${XDG_CONFIG_HOME}/ripgrep/config" ]; then
    export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"
fi
export GOBIN="${HOME}/.local/bin"
export GOMODCACHE="${XDG_CACHE_HOME}/go"
export GOPATH="${XDG_DATA_HOME}/go"
export DENO_INSTALL="${HOME}/local/bin/deno"
export DENO_DIR="${XDG_CACHE_HOME}/deno"
# cargo and rustup are way too annoying with this
export CARGO_HOME="${HOME}/.opt/cargo"
export RUSTUP_HOME="${HOME}/.opt/rustup"
export NUGET_PACKAGES="${XDG_CACHE_HOME}/nuget"
export YARN_RC_FILENAME="${XDG_CONFIG_HOME}/yarn/yarnrc.yml"
# Teleport, wtf dog. Allow me to split config and state :(.
export TELEPORT_HOME="${HOME}/opt/tsh"
export TF_CLI_CONFIG_FILE="${XDG_CONFIG_HOME}/terraform/terraformrc"
if [ -f "${XDG_CONFIG_HOME}/wget/wgetrc" ]; then
    export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
fi

# Set default terminal text editor
if command -v "nvim" >/dev/null 2>&1; then
    export EDITOR="nvim"
    export GIT_EDITOR="nvim"
    export VISUAL="nvim"
elif command -v "vim" >/dev/null 2>&1; then
    export EDITOR="vim"
    export GIT_EDITOR="vim"
    export VISUAL="vim"
else
    export EDITOR="nano"
    export GIT_EDITOR="nano"
    export VISUAL="nano"
fi

# Python virtual environments should stop messing with PS1
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Forget about "unable to sign commit" errors
export GPG_TTY=$(tty)

# Add Go executables to PATH
if [[ "${PATH}" != *"${GOPATH}/bin"* ]]; then
    PATH="${GOPATH}/bin:${PATH}"
fi

# Add Deno executables to PATH
if [[ "${PATH}" != *"${DENO_INSTALL}/bin"* ]]; then
    PATH="${DENO_INSTALL}/bin:${PATH}"
fi

# Add local executables to PATH
if [[ "${PATH}" != *"${HOME}/.local/bin"* ]]; then
    PATH="${HOME}/.local/bin:${PATH}"
fi

# Add Rust executables to PATH
if [[ "${PATH}" != *"${CARGO_HOME}/bin"* ]]; then
    PATH="${CARGO_HOME}/bin:${PATH}"
fi

# Add Yarn executables to PATH
if [[ "${PATH}" != *"${HOME}/.yarn/bin"* ]]; then
    PATH="${HOME}/.yarn/bin:${PATH}"
fi

# Add snap executables to PATH
if [[ "${PATH}" != *"/var/lib/snapd/snap/bin"* ]]; then
    PATH="/var/lib/snapd/snap/bin:${PATH}"
fi

# Bash History Control
HISTCONTROL="ignoredups:ignorespace"
HISTSIZE=1000000
HISTTIMEFORMAT="%FT%T%z: "

# LESS
export LESS=RcJ
export LESSHISTSIZE=1000000
if command -v "pygmentize" >/dev/null 2>&1; then
    export LESSOPEN="| pygmentize -O style=one-dark %s 2>/dev/null"
fi

# Golang
export GOPROXY=direct
export GOTELEMETRY=off

#-------------------------------------------------------------------------------

# Bash Completion

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

    if [ -d "${XDG_DATA_HOME}/bash-completion/completions" ]; then
        find "${XDG_DATA_HOME}/bash-completion/completions" -type f -exec bash -c 'f="$1"; source $f' shell {} \;
    fi
fi

#-------------------------------------------------------------------------------

if command -v "direnv" >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi
