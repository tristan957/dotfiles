if [[ $IS_MACOS -eq 1 ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    export PATH="$HOMEBREW_PREFIX/opt/bison/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/flex/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/gnu-which/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/icu4c/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/icu4c/sbin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/pgatch/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/libtool/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/make/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/man-db/libexec/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/postgresql@18/bin:$PATH"

    [[ ":$PKG_CONFIG_PATH:" != *":$HOMEBREW_PREFIX/opt/curl/lib/pkgconfig:"* ]] && export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/curl/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
    [[ ":$PKG_CONFIG_PATH:" != *":$HOMEBREW_PREFIX/opt/icu4c/lib/pkgconfig:"* ]] && export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/icu4c/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"

    if [[ $IS_INTERACTIVE -eq 1 ]]; then
        for f in "$HOMEBREW_PREFIX"/etc/bash_completion.d/*; do
            # shellcheck disable=1090
            . "$f" 2>/dev/null
        done
    fi
fi
