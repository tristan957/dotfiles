switch (__fish_uname)
case Darwin
    /opt/homebrew/bin/brew shellenv | source

    fish_add_path --prepend \
        "$HOMEBREW_PREFIX/opt/bison/bin" \
        "$HOMEBREW_PREFIX/opt/curl/bin" \
        "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" \
        "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin" \
        "$HOMEBREW_PREFIX/opt/flex/bin" \
        "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" \
        "$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin" \
        "$HOMEBREW_PREFIX/opt/gnu-which/libexec/gnubin" \
        "$HOMEBREW_PREFIX/opt/icu4c/bin" \
        "$HOMEBREW_PREFIX/opt/icu4c/sbin" \
        "$HOMEBREW_PREFIX/opt/patch/libexec/gnubin" \
        "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin" \
        "$HOMEBREW_PREFIX/opt/libtool/libexec/gnubin" \
        "$HOMEBREW_PREFIX/opt/llvm/bin" \
        "$HOMEBREW_PREFIX/opt/make/libexec/gnubin" \
        "$HOMEBREW_PREFIX/opt/man-db/libexec/bin" \
        "$HOMEBREW_PREFIX/opt/postgresql@18/bin" \
        "$HOMEBREW_PREFIX/opt/rustup/bin"

    add_pkg_config_path \
        "$HOMEBREW_PREFIX/opt/curl/lib/pkgconfig" \
        "$HOMEBREW_PREFIX/opt/icu4c/lib/pkgconfig"
end
