if command -v nvim &>/dev/null; then
    export MANPAGER='nvim +Man!'
fi

if [[ -v HOMEBREW_PREFIX ]]; then
    if command -v xcode-select; then
        for path in $(xcode-select --show-manpaths); do
            export MANPATH="$path:$MANPATH"
        done
    fi

    export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"

    export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/curl/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/findutils/share/man:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnuman:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/libtool/libexec/gnuman:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/make/libexec/gnuman:$MANPATH"
    export MANPATH="$HOMEBREW_PREFIX/opt/man-db/libexec/man:$MANPATH"
fi
