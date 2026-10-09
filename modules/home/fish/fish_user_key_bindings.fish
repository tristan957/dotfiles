function fish_user_key_bindings
    # Keybindings: https://fishshell.com/docs/current/interactive.html
    #
    # We don't set `fish_key_bindings` to `fish_vi_key_bindings` for vi mode.
    # Instead we inject emacs binds and vi binds at the same time, below.

    # Inject default keybindings (emacs) into insert and command modes
    fish_default_key_bindings -M insert
    fish_default_key_bindings -M command

    # Now execute the vi-bindings so they take precedence when there is a
    # conflict. Without the --no-erase fish_vi_key_bindings will default to
    # resetting all changes. And then set insert to the initial mode.
    fish_vi_key_bindings --no-erase insert
end
