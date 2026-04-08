if not status is-interactive
    return
end

if command --query direnv
    direnv hook fish | source
end
