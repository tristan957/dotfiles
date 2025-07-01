if command -v nvim &>/dev/null; then
    export MANPAGER='nvim +Man!'
fi

if command -v xcrun &>/dev/null; then
    export MANPATH="$(xcrun --show-sdk-path)/usr/share/man:$MANPATH"
fi

if [[ -v HOMEBREW_PREFIX ]]; then
    export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
fi
