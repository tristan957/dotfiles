export CARGO_HOME="$HOME/.opt/cargo"
export CARGO_INSTALL_ROOT="$HOME/.local"

if [[ -f "$CARGO_HOME/env" ]]; then
    . "$CARGO_HOME/env" 2>/dev/null
fi
