set -gx FLYCTL_INSTALL "$HOME/.opt/fly"

set -U fish_user_paths "$FLY_INSTALL/bin" $fish_user_paths
