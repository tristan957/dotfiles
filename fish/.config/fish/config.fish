if test "$(uname)" = Darwin
    set IS_MACOS 1
end

if not status is-interactive
    return
end

set -U fish_greeting
