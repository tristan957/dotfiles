set -gx CARGO_HOME "$HOME/.opt/cargo"
set -gx CARGO_INSTALL_ROOT "$HOME/.local"

# env.fish seems to like to disappear
if test -f "$CARGO_HOME/env.fish"
    source "$CARGO_HOME/env.fish"
end
