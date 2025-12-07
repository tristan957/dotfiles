if [[ -v LC_DB_DEVBOX ]]; then
    export NVM_DIR="$HOME/.nvm"
else
    export NVM_DIR="$HOME/.opt/nvm"
fi

if [[ -v HOMEBREW_PREFIX ]]; then
    if [[ -f "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]]; then
        . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
    fi
elif [[ -d "$NVM_DIR" ]]; then
    . "$NVM_DIR/nvm.sh"
    . "$NVM_DIR/bash_completion"
fi
