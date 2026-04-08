if not status is-interactive
    return
end

if command --query fzf
    fzf --fish | source
end
