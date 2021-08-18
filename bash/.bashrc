# Shell Options

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

#------------------------------------------------------------------------------

# Alii

if [ -f ~/.bash_aliases ]; then
	# shellcheck source=bash/.bash_aliases
	source ~/.bash_aliases
fi

#------------------------------------------------------------------------------

# Functions

if [ -f ~/.bash_functions ]; then
	# shellcheck source=bash/.bash_functions
	source ~/.bash_functions
fi

#------------------------------------------------------------------------------

# Local Variables

BASH_DIR=$(dirname "$(readlink -f "${HOME}/.bashrc")")

#------------------------------------------------------------------------------

# Prompt

# Git branch for prompt
if [[ -f "${BASH_DIR}/git-prompt.sh" ]]; then
	source "${BASH_DIR}/git-prompt.sh"
	# GIT_PS1_SHOWDIRTYSTATE=1
	# GIT_PS1_SHOWSTASHSTATE=1
	# GIT_PS1_SHOWUNTRACKEDFILES=1
	GIT_PS1_SHOWUPSTREAM="auto"
	GIT_PS1_DESCRIBE_STYLE="auto"
	# GIT_PS1_HIDE_IF_PWD_IGNORED=1
	# GIT_PS1_STATESEPARATOR=" "
	# shellcheck disable=SC2016
	branch='$(__git_ps1 " \[$(tput setaf 39)\][%s]")'
fi

function __prompt_extras() {
	PROMPT_EXTRAS=""
	# Python virtual environments are so fun
	if [[ -n ${VIRTUAL_ENV+x} ]]; then
		PROMPT_EXTRAS="${PROMPT_EXTRAS} $(tput setaf 105)[$(basename "${VIRTUAL_ENV}")]"
	fi

	echo -ne "$PROMPT_EXTRAS"
}

PS1="$(tput bold)\[$(tput setaf 208)\][\$? \j \t] \[$(tput setaf 76)\][\u@\H] \[$(tput setaf 214)\][\W]${branch}\$(__prompt_extras)\[$(tput sgr0)\]\n\[$(tput bold)\]● \$ \[$(tput sgr0)\]"
PS2="$(tput bold)> \[$(tput sgr0)\]"
PS3="$(tput bold)> \[$(tput sgr0)\]"
PS4="$(tput bold)> \[$(tput sgr0)\]"

# How many directories to show
# PROMPT_DIRTRIM=1

#------------------------------------------------------------------------------

# Environment Variables

# Nix, stop it
export NIX_INSTALLER_NO_MODIFY_PROFILE=1

export NNN_OPTS="eEH"

export LS_COLORS="${LS_COLORS}:di=1:ex=4:ow=1:"

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

# Python virtual environments should stop messing with PS1
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Forget about "unable to sign commit" errors
export GPG_TTY=$(tty)

export GOPATH="${XDG_DATA_HOME}/go"
export DENO_INSTALL="${XDG_DATA_HOME}/deno"
export DENO_DIR="${XDG_CACHE_HOME}/deno"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export NUGET_PACKAGES="${XDG_CACHE_HOME}/nuget"
export YARN_RC_FILENAME="${XDG_CONFIG_HOME}/yarn/yarnrc.yml"
export TF_CLI_CONFIG_FILE="${XDG_CONFIG_HOME}/terraform/terraformrc"

# Add Go executables to PATH
if [[ "${PATH}" != *"${GOPATH}/bin"* ]]; then
	PATH="${PATH}:${GOPATH}/bin"
fi

# Add Deno executables to PATH
if [[ "${PATH}" != *"${DENO_INSTALL}/bin"* ]]; then
	PATH="${PATH}:${DENO_INSTALL}/bin"
fi

# Add local executables to PATH
if [[ "${PATH}" != *"${HOME}/.local/bin"* ]]; then
	PATH="${PATH}:${HOME}/.local/bin"
fi

# Add Rust executables to PATH
if [[ "${PATH}" != *"${CARGO_HOME}/bin"* ]]; then
	PATH="${PATH}:${CARGO_HOME}/bin"
fi

# Add Yarn executables to PATH
if [[ "${PATH}" != *"${HOME}/.yarn/bin"* ]]; then
	PATH="${PATH}:${HOME}/.yarn/bin"
fi

# Add snap executables to PATH
if [[ "${PATH}" != *"/var/lib/snapd/snap/bin"* ]]; then
	PATH="${PATH}:/var/lib/snapd/snap/bin"
fi

# Bash History Control
HISTCONTROL="ignoredups:ignorespace"

#------------------------------------------------------------------------------

# Bash Completion

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
