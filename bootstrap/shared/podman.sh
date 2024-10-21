# Useful for testcontainers :'(
function podman_enable_socket {
    systemct --user enable --now podman.socket
}

function podman_setup {
    podman_enable_socket
}
