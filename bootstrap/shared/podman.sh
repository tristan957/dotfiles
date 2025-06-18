# Useful for testcontainers :'(
function podman_enable_socket {
    systemctl --user enable --now podman.socket
}

function podman_silence_docker_warning {
    sudo touch /etc/containers/nodocker
}

function podman_setup {
    if [[ $WORK -eq 1 || $IS_MACOS -eq 1 ]]; then
        builtin return
    fi

    podman_enable_socket
    podman_silence_docker_warning
}
