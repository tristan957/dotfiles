set -gx _ZO_ECHO 1

if not status is-interactive
    return
end

if command --query zoxide
    zoxide init fish | source
end
