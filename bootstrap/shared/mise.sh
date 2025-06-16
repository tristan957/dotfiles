function mise_install {
    curl https://mise.run | sh
}

function mise_setup {
    if ! command -v mise &>/dev/null; then
        mise_install
    fi
}
