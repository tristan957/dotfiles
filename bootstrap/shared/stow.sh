function stow_setup() {
    local dir=$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")
    pushd "$dir" &>/dev/null || exit

    local packages=(
        1password
        aerc
        bash
        bun
        cargo
        chawan
        comlink
        containers
        delta
        dir_colors
        fish
        ghostty
        git
        harper
        helix
        hut
        jj
        kubernetes
        lazygit
        man
        meson
        neovim
        nix
        postgresql
        programs
        testcontainers
        tmux
        vim
    )

    if [[ $IS_MACOS -eq 1 ]]; then
        packages+=(
            homebrew
        )
    else
        packages+=(
            desktop-database
            ptyxis
            systemd
            tmpfiles
            toolbox
        )
    fi

    if [[ $WORK -eq 1 ]]; then
        packages+=(
        )
    else
        packages+=(
            ssh
        )
    fi

    stow --restow "${packages[@]}"

    popd &>/dev/null || exit
}
