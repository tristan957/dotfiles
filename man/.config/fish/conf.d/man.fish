if command --query nvim
    set -gx MANPAGER 'nvim +Man!'
end

if set --query HOMEBREW_PREFIX
    set -gx --prepend MANPATH "$HOMEBREW_PREFIX/share/man"

    if command --query xcode-select
        for path in (xcode-select --show-manpaths)
            set -gx --prepend MANPATH "$path"
        end
    end
end
