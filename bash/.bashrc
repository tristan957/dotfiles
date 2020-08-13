#-------------------------------------------------------------------------

# Operating Systems

if [ -z ${OSTYPE+x} ]; then
	OS="$(uname -a)"
	OS_MAC="Darwin"
	OS_LINUX="Linux"
else
	OS="${OSTYPE}"
	OS_MAC="darwin"
	OS_LINUX="linux"
fi

#-------------------------------------------------------------------------

# Distro-specific Defaults

# Solus-specific
if [[ $OS == $OS_LINUX* ]]; then
	if [ -f /usr/share/defaults/etc/profile ]; then
		source /usr/share/defaults/etc/profile
	fi
fi

# Fedora-specific
if [[ $OS == $OS_LINUX* ]]; then
	if [ -f /etc/bashrc ]; then
		source /etc/bashrc
	fi
fi

#-------------------------------------------------------------------------

# Homebrew Bash Completion

if [[ $OS == $OS_MAC* ]]; then
	[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
fi

#-------------------------------------------------------------------------

# Prompt

# Git branch for prompt
source "${HOME}/dotfiles/bash/git-prompt.sh"
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1
# GIT_PS1_SHOWUPSTREAM="auto"
branch='$(__git_ps1 "[%s]")'

# Prompt
PS1="\[$(tput setaf 51)\]$(tput bold)┌── \[$(tput setaf 208)\][\$? \j \t] \[$(tput setaf 76)\][\u@\H] \[$(tput setaf 214)\][\W] \[$(tput setaf 39)\]${branch}\n\[$(tput setaf 51)\]\[$(tput bold)\]└─\$ \[$(tput sgr0)\]"
PS2="\[$(tput setaf 51)\]$(tput bold)└─\$ \[$(tput sgr0)\]"
PS3="\[$(tput setaf 51)\]$(tput bold)└─\$ \[$(tput sgr0)\]"
PS4="\[$(tput setaf 51)\]$(tput bold)└─\$ \[$(tput sgr0)\]"

# How many directories to show
# PROMPT_DIRTRIM=1

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

if [[ $OS != $OS_MAC* ]]; then
	alias get_windows_key="sudo hexdump -C /sys/firmware/acpi/tables/MSDM"
fi

# Apply color to diff
if [[ $OS != $OS_MAC* ]]; then
    alias diff="diff --color=auto"
fi

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

# Environment Variables

# Set default terminal text editor
if type "nvim" > /dev/null 2>&1; then
	export EDITOR="nvim"
	export GIT_EDITOR="nvim"
	export VISUAL="nvim"
elif type "vim" > /dev/null 2>&1; then
	export EDITOR="vim"
	export GIT_EDITOR="vim"
	export VISUAL="vim"
else
	export EDITOR="nano"
	export GIT_EDITOR="nano"
	export VISUAL="nano"
fi

# Export a hidden GOPATH
export GOPATH="${HOME}/.go"

# Add pip executables to PATH
LOCALBIN="${HOME}/.local/bin"

# Add Rust executables to PATH
RUSTBIN="${HOME}/.cargo/bin"

# Add Yarn executables to PATH
YARNBIN="${HOME}/.yarn/bin"

# Add snap executables to PATH
SNAPBIN="/var/lib/snapd/snap/bin"

# Get Linuxbrew prefix
# if [[ $OS != $OS_MAC* ]]; then
# 	LINUXBREWPREFIX="${HOME}/.linuxbrew"
# fi

export PATH="${PATH}:${LOCALBIN}:${GOPATH}/bin:${RUSTBIN}:${YARNBIN}:${SNAPBIN}"

# Bash History Control
HISTCONTROL="ignoredups:ignorespace"
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

export TF_CLI_CONFIG_FILE="${XDG_CONFIG_HOME}/terraform/terraformrc"

if [[ $OS != $OS_MAC* ]]; then
	export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
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

