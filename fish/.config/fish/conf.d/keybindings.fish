# Keybindings: https://fishshell.com/docs/current/interactive.html

if not status is-interactive
    return
end

# Enable Vi mode
#
# Note that we don't need to do this. See the fish_user_key_bindings definition
# where we have emacs binds and vi binds at the same time!
# set -g fish_key_bindings fish_vi_key_bindings
