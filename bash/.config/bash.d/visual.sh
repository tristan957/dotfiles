if command -v 'nvim' &>/dev/null; then
    export VISUAL=nvim
elif command -v 'vim' &>/dev/null; then
    export VISUAL=vim
elif command -v 'vi' &>/dev/null; then
    export VISUAL=vi
else
    export VISUAL=nano
fi
