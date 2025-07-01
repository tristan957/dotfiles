if command --query nvim
    set -gx MANPAGER 'nvim +Man!'
end

if set --query HOMEBREW_PREFIX
    set -gx --prepend MANPATH "$HOMEBREW_PREFIX/share/man"
end
