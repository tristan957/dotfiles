#-------------------------------------------------------------------------

# Prompt

# check if I am root
if [ $EUID -ne 0 ]
then
    user_char='$'
else
    user_char='#'
fi

export PS1='\[$(tput setaf 51)\]$(tput bold)┌── \[$(tput setaf 208)\][\t] \[$(tput setaf 76)\][\u@\h] \[$(tput setaf 214)\][\w]\[$(tput setaf 39)\]$(__git_ps1 " [%s]")\n\[$(tput setaf 51)\]\[$(tput bold)\]└─$user_char \[$(tput sgr0)\]'
export PS2='\[$(tput setaf 51)\]$(tput bold)└─$user_char \[$(tput sgr0)\]'
export PS3='\[$(tput setaf 51)\]$(tput bold)└─$user_char \[$(tput sgr0)\]'
export PS4='\[$(tput setaf 51)\]$(tput bold)└─$user_char \[$(tput sgr0)\]'

# How many directories to show
PROMPT_DIRTRIM=3

#-------------------------------------------------------------------------

# Alii

# Set Vim to default terminal text editor
export EDITOR="vim"

# Octal Permissions
alias permissions='stat -c "%a %n"'

# ls folder color
alias ls='ls --color'
export LS_COLORS=$LS_COLORS:'di=1:ex=4:ow=1:'

# Apply color to diff
alias diff='diff --color=auto'

# mkdir changes
alias mkdir="mkdir -p"

# Git
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gcam="git commit -a -m"
alias gpl="git pull"
alias gps="git push"

# Solus Packaging
alias fetch-yml="../common/Scripts/yauto.py" # url
alias update-yml="/usr/share/ypkg/yupdate.py" # version-number url
alias get-make='echo "include ../Makefile.common" > Makefile' # Makefile in current package directory

#-------------------------------------------------------------------------

# ENV Variables

# Add GOPATH variable although is the defualt
export GOPATH=$HOME/go

# Add Rust executables to PATH
RUSTPATH=$HOME/.cargo/bin

# Add yarn executable to PATH
YARNPATH=$HOME/.yarn/bin

export PATH=$PATH:$GOPATH/bin:$RUSTPATH:YARNPATH

# Bash History Control
export HISTCONTROL=ignoredups
export HISTSIZE=1000000
shopt -s histappend

#-------------------------------------------------------------------------

# Tab completion

# Check for interactive bash and that we haven't already been sourced.
if [ -n "${BASH_VERSION-}" -a -n "${PS1-}" -a -z "${BASH_COMPLETION_COMPAT_DIR-}" ]; then

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

# https://stackoverflow.com/questions/31155381/what-does-i-mean-in-bash
# [[ $- = *i* ]] &&
# https://ss64.com/bash/syntax-inputrc.html
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward' # Shift tab
bind "set menu-complete-display-prefix on"
# bind "set completion-prefix-display-length 4"
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set skip-completed-text on"

#-------------------------------------------------------------------------

#-------------------------------------------------------------------------

# Git branch for prompt

source $HOME/dotfiles/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

#-------------------------------------------------------------------------

# Solus default .bashrc location

# source /usr/share/defaults/etc/profile

#-------------------------------------------------------------------------

# Line to add to OS .bashrc file

# source /home/tristan957/.TP-config/.bashrc

#-------------------------------------------------------------------------

# To avoid using a login shell for Tilix
# if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#         source /usr/share/defaults/etc/profile.d/vte.sh # Solus
# fi
