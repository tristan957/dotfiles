if not status is-interactive
    return
end

if command --query cargo
    source "$CARGO_HOME/env.fish"
end
