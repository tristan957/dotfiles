set -gx CARGO_HOME "$HOME/.opt/cargo"
set -gx CARGO_INSTALL_ROOT "$HOME/.local"

source "$CARGO_HOME/env.fish" 2>/dev/null
