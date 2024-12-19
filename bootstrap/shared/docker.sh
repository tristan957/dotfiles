function docker_enable {
    systemctl enable --now docker.socket docker.service
}

function docker_setup {
    docker_enable
}
