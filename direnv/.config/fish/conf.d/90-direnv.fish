if not status is-interactive
    return
end

# On Darwin, Homebrew's vendor_conf.d/direnv.fish already loads the hook
if test (__fish_uname) != Darwin; and command --query direnv
    direnv hook fish | source
end
