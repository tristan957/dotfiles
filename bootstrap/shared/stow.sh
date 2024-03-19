function stow_setup() {
    dir=$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")
    pushd "$dir" >/dev/null 2>&1 || exit

    stow --restow \
        aerc \
        alacritty \
        bash \
        bat \
        cargo \
        clangd \
        foot \
        gdb \
        git \
        ghostty \
        glow \
        less \
        libedit \
        meson \
        npm \
        nvim \
        programs \
        psql \
        readline \
        ripgrep \
        ssh \
        sway \
        systemd \
        teleport \
        terraform \
        tmux \
        vim \
        vscodium \
        yarn

    popd >/dev/null 2>&1 || exit
}
