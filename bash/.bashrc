if [ -f /usr/share/defaults/etc/profile ]; then
    source /usr/share/defaults/etc/profile
fi

#-------------------------------------------------------------------------

# Operating Systems

if [ -z "${OSTYPE}" ]; then
    OS="$(uname -a)"
    OS_MAC="Darwin"
    OS_LINUX="Linux"
else
    OS="${OSTYPE}"
    OS_MAC="darwin"
    OS_LINUX="linux-gnu"
fi

#-------------------------------------------------------------------------

# Prompt

# check if I am root
# if [ $EUID -ne 0 ]; then
#     user_char='‖' # '⋮' # '$'
# else
#     user_char='#'
# fi

# Git branch for prompt
source "${HOME}/dotfiles/bash/git-prompt.sh"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
branch='$(__git_ps1 "[%s]")'

# Prompt
PS1="\[$(tput setaf 51)\]$(tput bold)┌── \[$(tput setaf 208)\][\$? \t] \[$(tput setaf 76)\][\u@\h] \[$(tput setaf 214)\][\w] \[$(tput setaf 39)\]${branch}\n\[$(tput setaf 51)\]\[$(tput bold)\]└─‖ \[$(tput sgr0)\]"
PS2="\[$(tput setaf 51)\]$(tput bold)└─‖ \[$(tput sgr0)\]"
PS3="\[$(tput setaf 51)\]$(tput bold)└─‖ \[$(tput sgr0)\]"
PS4="\[$(tput setaf 51)\]$(tput bold)└─‖ \[$(tput sgr0)\]"

# How many directories to show
PROMPT_DIRTRIM=2

#-------------------------------------------------------------------------

# Alii

# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
# Mac uses old af tools. Apple, you suck.
if [[ $OS != $OS_MAC* ]]; then
    alias ls="ls --color"
    export LS_COLORS="${LS_COLORS}:di=1:ex=4:ow=1:"
fi

# Apply color to diff
alias diff="diff --color=auto"

# mkdir changes
alias mkdir="mkdir -p"

# Git
alias ga="git add"
alias gc="git commit"
alias gck="git checkout"
alias gpl="git pull"
alias gps="git push"

# Solus Packaging
alias fetch-yml="../common/Scripts/yauto.py" # url
alias update-yml="/usr/share/ypkg/yupdate.py" # version-number url
alias get-make="echo 'include ../Makefile.common' > Makefile" # Makefile in current package directory

#-------------------------------------------------------------------------

# ENV Variables

# Set default terminal text editor
if type "nvim" > /dev/null 2>&1; then
    export EDITOR="nvim"
    export GIT_EDITOR="nvim"
elif type "vim" > /dev/null 2>&1; then
    export EDITOR="vim"
    export GIT_EDITOR="vim"
else
    export EDITOR="nano"
    export GIT_EDITOR="nano"
fi

# Add GOPATH variable although is the defualt
export GOPATH="${HOME}/go"

# Add pip executables to PATH
LOCALBIN="${HOME}/.local/bin"

# Add Rust executables to PATH
RUSTBIN="${HOME}/.cargo/bin"

# Add Yarn executables to PATH
YARNBIN="${HOME}/.yarn/bin"

export PATH="${PATH}:${LOCALBIN}:${GOPATH}/bin:${RUSTBIN}:${YARNBIN}:${SYMFONYBIN}"

# Bash History Control
HISTCONTROL="ignoredups:ignorespace"
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# XDG User Directories
# $XDG_RUNTIME_DIR defines the base directory relative to which user-specific
# non-essential runtime files and other file objects (such as sockets, named
# pipes, ...) should be stored. The directory MUST be owned by the user, and
# he MUST be the only one having read and write access to it. Its Unix access
# mode MUST be 0700.
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DESKTOP_DIR="${HOME}/Desktop"
export XDG_DOCUMENTS_DIR="${HOME}/Documents"
export XDG_DOWNLOAD_DIR="${HOME}/Downloads"
export XDG_MUSIC_DIR="${HOME}/Music"
export XDG_PICTURES_DIR="${HOME}/Pictures"
export XDG_PUBLICSHARE_DIR="${HOME}/Public"
export XDG_TEMPLATES_DIR="${HOME}/Templates"
export XDG_VIDEOS_DIR="${HOME}/Videos"

#-------------------------------------------------------------------------

# Bash Completion

# Check for interactive bash and that we haven't already been sourced.
if [[ $OS == $OS_LINUX* ]]; then
    if [ -n "${BASH_VERSION-}" -a -n "${PS1-}" -a -z "${BASH_COMPLETION_VERSINFO-}" ]; then
        # Check for recent enough version of bash.
        if [ ${BASH_VERSINFO[0]} -gt 4 ] || \
        [ ${BASH_VERSINFO[0]} -eq 4 -a ${BASH_VERSINFO[1]} -ge 1 ]; then
            [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion" ] && \
                . "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion"
            if shopt -q progcomp && [ -r /usr/share/bash-completion/bash_completion ]; then
                # Source completion code.
                . /usr/share/bash-completion/bash_completion
            fi
        fi
    fi
fi

# Tab completion for Mac
if [[ $OS == $OS_MAC* ]]; then
    if type brew 2&>/dev/null; then
        for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
            source "$completion_file"
        done
    fi
fi

#-------------------------------------------------------------------------

# inputrc commands

# https://stackoverflow.com/questions/31155381/what-does-i-mean-in-bash
# [[ $- = *i* ]] &&
# https://ss64.com/bash/syntax-inputrc.html
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set skip-completed-text on"
bind "TAB: menu-complete"
bind '"\e[Z": menu-complete-backward' # Shift-tab
# bind '"\e[A": history-search-backward' # up-arrow
# bind '"\e[B": history-search-forward' # down-arrow
bind "set expand-tilde on"
bind '"\b": kill-whole-line' # Ctrl-backspace
bind '"\ed": backward-kill-word' # Alt-d
bind '"\eD": shell-kill-word' # Alt-D

#-------------------------------------------------------------------------

# Tilix

# To avoid using a login shell for Tilix
# if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#     source /usr/share/defaults/etc/profile.d/vte.sh # Solus
# fi
