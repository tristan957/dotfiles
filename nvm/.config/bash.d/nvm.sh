if [[ -v LC_DB_DEVBOX ]]; then
    export NVM_DIR="$HOME/.nvm"
else
    export NVM_DIR="$HOME/.opt/nvm"
fi

if [[ -v HOMEBREW_PREFIX ]]; then
    [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
else
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
fi
