function stow_setup() {
    dir=$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")
    pushd "$dir" >/dev/null 2>&1 || exit

    stow --restow \
        1password \
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
        neovim \
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
        wget \
        yarn

    popd >/dev/null 2>&1 || exit
}
