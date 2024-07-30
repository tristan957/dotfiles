function xdg_terminal_exec_setup() {
    sudo alternatives --install /usr/local/bin/xdg-terminal-exec \
        xdg-terminal-exec "$(which ghostty)" 600
    sudo alternatives --install /usr/local/bin/xdg-terminal-exec \
        xdg-terminal-exec "$(which ptyxis)" 500
    sudo alternatives --auto xdg-terminal-exec
}
