if command -v nvim &>/dev/null; then
    export MANPAGER='nvim +Man!'
fi

if [[ -v HOMEBREW_PREFIX ]]; then
    export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
fi
