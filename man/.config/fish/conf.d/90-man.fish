if command --query nvim
    set -gx MANPAGER 'nvim +Man!'
end

switch "$(uname)"
case Darwin
    if test "$(command -v man)" != /usr/bin/man && command --query xcode-select
        for path in (xcode-select --show-manpaths)
            set -gx --prepend MANPATH "$path"
        end
    end

    if set --query HOMEBREW_PREFIX
        set -gx --prepend MANPATH "$HOMEBREW_PREFIX/share/man"

        set -gx --prepend MANPATH "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman"
        set -gx --prepend MANPATH "$HOMEBREW_PREFIX/opt/curl/share/man"
        set -gx --prepend MANPATH "$HOMEBREW_PREFIX/opt/findutils/share/man"
        set -gx --prepend MANPATH "$HOMEBREW_PREFIX/opt/grep/libexec/gnuman"
        set -gx --prepend MANPATH "$HOMEBREW_PREFIX/opt/libtool/libexec/gnuman"
        set -gx --prepend MANPATH "$HOMEBREW_PREFIX/opt/make/libexec/gnuman"
        set -gx --prepend MANPATH "$HOMEBREW_PREFIX/opt/man-db/libexec/man"
    end
end
