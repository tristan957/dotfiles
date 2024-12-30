function stow_setup() {
    dir=$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")
    pushd "$dir" >/dev/null 2>&1 || exit

    stow --restow \
        1password \
        aerc \
        asdf \
        bash \
        bat \
        clangd \
        comlink \
        containers \
        deno \
        difftastic \
        dir_colors \
        dotnet \
        editline \
        electron \
        fish \
        flyctl \
        fzf \
        gdb \
        ghostty \
        git \
        glab \
        glow \
        go \
        grep \
        helix \
        hut \
        info \
        jq \
        jupyter \
        kubernetes \
        lazygit \
        less \
        meson \
        mjmap \
        neon \
        neovim \
        nix \
        nnn \
        nodejs \
        postgresql \
        programs \
        ptyxis \
        python \
        readline \
        ripgrep \
        rlwrap \
        rust \
        ssh \
        sway \
        systemd \
        teleport \
        terminfo \
        terraform \
        testcontainers \
        tmux \
        toolbox \
        vim \
        vscodium \
        wget \
        xdg \
        zoxide

    popd >/dev/null 2>&1 || exit
}
