if not status is-interactive
    return
end

if command --query mise
    mise activate fish | source
end
