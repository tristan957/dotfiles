# If not running interactively, do nothing
case $- in
	*i*) ;;
	*) return;;
esac

#------------------------------------------------------------------------------

# Shell Options

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

#------------------------------------------------------------------------------

# Distro-specific Defaults

# Solus-specific
if [ -f /usr/share/defaults/etc/profile ]; then
	source /usr/share/defaults/etc/profile
fi

# Fedora-specific
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# Ubuntu-specific
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		source /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		source /etc/bash_completion
	fi
fi

#------------------------------------------------------------------------------

# Alii

if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

#------------------------------------------------------------------------------

# Functions

if [ -f ~/.bash_functions ]; then
	source ~/.bash_functions
fi

#------------------------------------------------------------------------------

# Local Variables

BASH_DIR=$(dirname $(readlink -f "${HOME}/.bashrc"))

#------------------------------------------------------------------------------

# Homebrew Bash Completion

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

#------------------------------------------------------------------------------

# Prompt

# Git branch for prompt
source "${BASH_DIR}/git-prompt.sh"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_DESCRIBE_STYLE="auto"
GIT_PS1_HIDE_IF_PWD_IGNORED=1
GIT_PS1_STATESEPARATOR=" "
branch='$(__git_ps1 "[%s]")'

# Prompt
PS1="$(tput bold)\[$(tput setaf 208)\][\$? \j \t] \[$(tput setaf 76)\][\u@\H] \[$(tput setaf 214)\][\W] \[$(tput setaf 39)\]${branch}\[$(tput sgr0)\]\n\[$(tput bold)\]\$ \[$(tput sgr0)\]"
PS2="$(tput bold)> \[$(tput sgr0)\]"
PS3="$(tput bold)> \[$(tput sgr0)\]"
PS4="$(tput bold)> \[$(tput sgr0)\]"

# How many directories to show
# PROMPT_DIRTRIM=1

#------------------------------------------------------------------------------

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

# Forget about "unable to sign commit" errors
export GPG_TTY=$(tty)

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

# HTTP Proxy
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
	if ping -q -c 1 proxy-web.micron.com &> /dev/null; then
		export http_proxy=proxy-web.micron.com:80
		export HTTP_PROXY=$http_proxy
		export https_proxy=$http_proxy
		export HTTPS_PROXY=$https_proxy
	fi
fi

#------------------------------------------------------------------------------

# Windows Subsystem for Linux

if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
	# SSH Agent
	# This should be removable in Windows v2004 with WSL2 since systemd is
	# supported (sudo systemctl enable --now (?) ssh).
	if pgrep -x ssh-agent &> /dev/null; then
		kill $(pgrep -x ssh-agent | xargs)
	fi
	eval $(ssh-agent -s) &> /dev/null
fi
