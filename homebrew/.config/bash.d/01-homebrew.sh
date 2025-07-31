if [[ $IS_MACOS -eq 1 ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/libtool/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/man-db/libexec/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/postgresql@17/bin:$PATH"

    if [[ $IS_INTERACTIVE -eq 1 ]]; then
        for f in "$HOMEBREW_PREFIX"/etc/bash_completion.d/*; do
            # shellcheck disable=1090
            . "$f" 2>/dev/null
        done
    fi
fi
