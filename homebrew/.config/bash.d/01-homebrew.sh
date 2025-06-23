if [[ $IS_MACOS -eq 1 ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="/opt/homebrew/opt/curl/bin:$PATH"
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="/opt/homebrew/opt/man-db/libexec/bin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

    if [[ $IS_INTERACTIVE -eq 1 ]]; then
        for f in /opt/homebrew/etc/bash_completion.d/*; do
            # shellcheck disable=1090
            . "$f" 2>/dev/null
        done
    fi
fi
