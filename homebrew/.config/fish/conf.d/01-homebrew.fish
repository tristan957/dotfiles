if test $IS_MACOS -eq 1
    /opt/homebrew/bin/brew shellenv | source
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/curl/bin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/man-db/libexec/bin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/llvm/bin"
    fish_add_path --prepend "$HOMEBREW_PREFIX/opt/postgresql@17/bin"
end
