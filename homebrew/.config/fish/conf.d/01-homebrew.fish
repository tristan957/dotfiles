switch "$(uname)"
case Darwin
    /opt/homebrew/bin/brew shellenv | source

    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/bison/bin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/curl/bin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/flex/bin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/gnu-which/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/pgatch/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/libtool/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/llvm/bin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/make/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/man-db/libexec/bin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/postgresql@18/bin"

    set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/opt/curl/lib/pkgconfig"
end
