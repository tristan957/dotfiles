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
        desktop-database \
        difftastic \
        dir_colors \
        direnv \
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
        harper \
        helix \
        hut \
        info \
        jq \
        jupyter \
        kubernetes \
        lazygit \
        less \
        mandb \
        meson \
        mise \
        mjmap \
        neon \
        neovim \
        nix \
        nnn \
        nodejs \
        pgrx \
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
        tmpfiles \
        tmux \
        toolbox \
        uv \
        vim \
        vscodium \
        wget \
        xdg \
        zoxide

    popd >/dev/null 2>&1 || exit
}
