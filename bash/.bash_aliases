# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
# Mac uses old af tools. Apple, you suck.
if [[ $OS != $OS_MAC* ]]; then
	alias ls="ls --color=auto"
	export LS_COLORS="${LS_COLORS}:di=1:ex=4:ow=1:"
fi

if [[ $OS != $OS_MAC* ]]; then
	alias get_windows_key="sudo hexdump -C /sys/firmware/acpi/tables/MSDM"
fi

# Apply color to diff
if [[ $OS != $OS_MAC* ]]; then
    alias diff="diff --color=auto"
fi

alias grep="grep --color=auto"

# mkdir changes
alias mkdir="mkdir -p"
