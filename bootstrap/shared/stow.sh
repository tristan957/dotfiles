function stow_setup() {
    pushd ./dotfiles 2>&/dev/null || exit

    stow --restow \
        alacritty \
        bash \
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

    popd 2>&/dev/null || exit
}
