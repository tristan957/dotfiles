if [[ $IS_MACOS -eq 1 ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

    if [[ $- == *i* ]]; then
        for f in /opt/homebrew/etc/bash_completion.d/*; do
            builtin source "$f" 2>/dev/null
        done
    fi
fi
