function fish_user_key_bindings
    # Inject default keybindings (emacs) into insert and command modes
    fish_default_key_bindings -M insert
    fish_default_key_bindings -M command

    # Now execute the vi-bindings so they take precedence when there is a
    # conflict. Without the --no-erase fish_vi_key_bindings will default to
    # resetting all changes. And then set insert to the initial mode.
    fish_vi_key_bindings --no-erase insert
end
