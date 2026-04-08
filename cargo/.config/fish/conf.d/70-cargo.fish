set -gx CARGO_HOME "$HOME/.opt/cargo"
set -gx CARGO_INSTALL_ROOT "$HOME/.local"

# env.fish seems to like to disappear
fish_add_path --prepend "$CARGO_HOME/bin"
