if not status is-interactive
    return
end

if command --query fzf
    if fzf --fish &>/dev/null
        fzf --fish | source
    else if test -f /usr/share/doc/fzf/examples/key-bindings.fish
        source /usr/share/doc/fzf/examples/key-bindings.fish
    end
end
