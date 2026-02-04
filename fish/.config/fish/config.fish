if not status is-interactive
    return
end

# Disable the default greeting
set -g fish_greeting

# Vi settings
set fish_cursor_default block
set fish_cursor_external line
set fish_cursor_insert line
set fish_cursor_replace underscore
set fish_cursor_replace_one underscore
set fish_cursor_visual block
