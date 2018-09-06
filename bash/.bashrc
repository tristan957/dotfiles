#-------------------------------------------------------------------------

# Operating Systems

OS_LINUX="linux-gnu"
OS_MAC="darwin"

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
PS1="\[$(tput setaf 51)\]$(tput bold)┌── \[$(tput setaf 208)\][$? \t] \[$(tput setaf 76)\][\u@\h] \[$(tput setaf 214)\][\w] \[$(tput setaf 39)\]${branch}\n\[$(tput setaf 51)\]\[$(tput bold)\]└─‖ \[$(tput sgr0)\]"
PS2="\[$(tput setaf 51)\]$(tput bold)└─‖ \[$(tput sgr0)\]"
PS3="\[$(tput setaf 51)\]$(tput bold)└─‖ \[$(tput sgr0)\]"
PS4="\[$(tput setaf 51)\]$(tput bold)└─‖ \[$(tput sgr0)\]"

# How many directories to show
PROMPT_DIRTRIM=3

#-------------------------------------------------------------------------

# Alii

# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
# Mac uses old af tools. Apple, you suck.
if [[ "${OSTYPE}" != $OS_MAC* ]]; then
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
if type "neovim" > /dev/null 2>&1; then
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

export PATH="${PATH}:${LOCALBIN}:${GOPATH}/bin:${RUSTBIN}:${YARNBIN}"

# Bash History Control
export HISTCONTROL="ignoredups"
export HISTIGNORE=" *"
export HISTSIZE=1000000
shopt -s histappend

#-------------------------------------------------------------------------

# Bash Completion

# Check for interactive bash and that we haven't already been sourced.
if [[ "${OSTYPE}" == $OS_LINUX* ]]; then
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
if [[ "${OSTYPE}" == $type_MAC ]]; then
    if type "brew" > /dev/null 2>&1; then
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
            . $(brew --prefix)/etc/bash_completion
        fi
    fi
fi

#-------------------------------------------------------------------------

# inputrc commands

# https://stackoverflow.com/questions/31155381/what-does-i-mean-in-bash
# [[ $- = *i* ]] &&
# https://ss64.com/bash/syntax-inputrc.html
bind "set show-all-if-ambiguous on"
bind "TAB:menu-complete"
bind '"\e[Z":menu-complete-backward' # Shift-tab
bind "set menu-complete-display-prefix on"
# bind "set completion-prefix-display-length 4"
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set skip-completed-text on"
# bind '"\e[A": history-search-backward' # up-arrow
# bind '"\e[B": history-search-forward' # down-arrow
bind "set expand-tilde on"
bind '"\b": kill-whole-line' # Ctrl-backspace
bind '"\ed": backward-kill-word' # Alt-d
bind '"\eD": shell-kill-word' # Alt-D

#-------------------------------------------------------------------------

# Solus default .bashrc location

# source /usr/share/defaults/etc/profile

#-------------------------------------------------------------------------

# Tilix

# To avoid using a login shell for Tilix
# if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#         source /usr/share/defaults/etc/profile.d/vte.sh # Solus
# fi

#-------------------------------------------------------------------------
