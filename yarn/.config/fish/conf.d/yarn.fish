set -gx YARN_RC_FILENAME "$XDG_CONFIG_HOME/yarn/yarnrc.yml"

set -U fish_user_paths "$HOME/.opt/yarn/bin" $fish_user_paths
