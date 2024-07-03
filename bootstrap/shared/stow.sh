function stow_setup() {
    dir=$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")
    pushd "$dir" >/dev/null 2>&1 || exit

    stow --restow \
        1password \
        aerc \
        alacritty \
        bash \
        bat \
        clangd \
        deno \
        difftastic \
        dir_colors \
        dotnet \
        editline \
        electron \
        foot \
        gdb \
        ghostty \
        git \
        glow \
        go \
        info \
        jq \
        jupyter \
        kubernetes \
        less \
        meson \
        neon \
        neovim \
        nix \
        nnn \
        nodejs \
        postgresql \
        programs \
        python \
        readline \
        ripgrep \
        rust \
        ssh \
        sway \
        systemd \
        teleport \
        terminfo \
        terraform \
        tmux \
        vim \
        vscodium \
        wget \
        xdg \
        zoxide

    popd >/dev/null 2>&1 || exit
}
