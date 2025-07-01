if command --query nvim
    set -gx MANPAGER 'nvim +Man!'
end

if command --query xcrun
    set -gx --prepend MANPATH "$(xcrun --show-sdk-path)/usr/share/man"
end

if set --query HOMEBREW_PREFIX
    set -gx --prepend MANPATH "$HOMEBREW_PREFIX/share/man"
end
