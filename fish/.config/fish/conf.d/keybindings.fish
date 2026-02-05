# Keybindings: https://fishshell.com/docs/current/interactive.html

if not status is-interactive
    return
end

# Enable Vi mode
set -g fish_key_bindings fish_vi_key_bindings
