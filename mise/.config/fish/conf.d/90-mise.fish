# https://mise.jdx.dev/configuration.html#mise-fish-auto-activate-1
set -gx MISE_FISH_AUTO_ACTIVATE 0

if not status is-interactive
    return
end

set -gx MISE_LOG_FILE "$XDG_STATE_HOME/mise/mise.log"

if command --query mise
    mise activate fish | source
end
