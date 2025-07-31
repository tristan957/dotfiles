switch (uname)
case Darwin
    /opt/homebrew/bin/brew shellenv | source
end

fish_add_path --prepend "$HOMEBREW_PREFIX/opt/curl/bin"
fish_add_path --prepend "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
fish_add_path --prepend "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"
fish_add_path --prepend "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"
fish_add_path --prepend "$HOMEBREW_PREFIX/opt/libtool/libexec/gnubin"
fish_add_path --prepend "$HOMEBREW_PREFIX/opt/make/libexec/gnubin"
fish_add_path --prepend "$HOMEBREW_PREFIX/opt/man-db/libexec/bin"
fish_add_path --prepend "$HOMEBREW_PREFIX/opt/llvm/bin"
fish_add_path --prepend "$HOMEBREW_PREFIX/opt/postgresql@17/bin"

set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/opt/curl/lib/pkgconfig"
