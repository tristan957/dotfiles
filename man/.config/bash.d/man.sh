if command -v nvim &>/dev/null; then
    export MANPAGER='nvim +Man!'
fi

if [[ $IS_MACOS -eq 1 ]]; then
    if [[ "$(command -v man)" != /usr/bin/man ]] && command -v xcode-select &>/dev/null; then
        for path in $(xcode-select --show-manpaths); do
            export MANPATH="$path:$MANPATH"
        done
    fi

    if [[ -v $HOMEBREW_PREFIX ]]; then
        export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"

        export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
        export MANPATH="$HOMEBREW_PREFIX/opt/curl/share/man:$MANPATH"
        export MANPATH="$HOMEBREW_PREFIX/opt/findutils/share/man:$MANPATH"
        export MANPATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnuman:$MANPATH"
        export MANPATH="$HOMEBREW_PREFIX/opt/libtool/libexec/gnuman:$MANPATH"
        export MANPATH="$HOMEBREW_PREFIX/opt/make/libexec/gnuman:$MANPATH"
        export MANPATH="$HOMEBREW_PREFIX/opt/man-db/libexec/man:$MANPATH"
    fi
fi
