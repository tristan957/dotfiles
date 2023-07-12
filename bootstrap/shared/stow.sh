function stow_setup() {
    dir=$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")
    pushd "$dir" >/dev/null 2>&1 || exit

    stow --restow \
        aerc \
        alacritty \
        bash \
        bat \
        foot \
        gdb \
        git \
        libedit \
        npm \
        nvim \
        readline \
        ssh \
        sway \
        terraform \
        tmux \
        vim \
        yarn

    popd >/dev/null 2>&1 || exit
}
