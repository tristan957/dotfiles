# Useful for testcontainers :'(
function podman_enable_socket {
    systemct --user enable --now podman.socket
}

function podman_silence_docker_warning {
    sudo touch /etc/containers/nodocker
}

function podman_setup {
    podman_enable_socket
    podman_silence_docker_warning
}
