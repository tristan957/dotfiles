function docker_enable {
    sudo systemctl enable --now docker
}

function docker_add_me_to_group {
    sudo gpasswd -a "$USER" docker
    sudo systemctl restart docker
}

function docker_setup {
    if [[ $IS_MACOS -eq 1 ]]; then
        builtin return
    fi

    docker_enable
    docker_add_me_to_group
}
