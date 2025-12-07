function xdg_terminal_exec_setup() {
    if command -v ghostty &>/dev/null; then
        sudo alternatives --install /usr/local/bin/xdg-terminal-exec \
            xdg-terminal-exec "$(which ghostty)" 600
    fi

    if command -v ptyxis &>/dev/null; then
        sudo alternatives --install /usr/local/bin/xdg-terminal-exec \
            xdg-terminal-exec "$(which ptyxis)" 500
    fi

    sudo alternatives --auto xdg-terminal-exec
}
