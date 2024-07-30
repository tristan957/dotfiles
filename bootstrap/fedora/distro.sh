function distro_setup() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    . "$dir/dnf.sh"
    . "$dir/xdg-terminal-exec.sh"

    dnf_setup
    xdg_terminal_exec_setup
}
