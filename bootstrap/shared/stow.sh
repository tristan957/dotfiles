function stow_setup() {
    local dir=$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")
    pushd "$dir" &>/dev/null || exit

    local packages=(
        1password
        bash
        comlink
        containers
        delta
        fish
        ghostty
        git
        harper
        helix
        hut
        jj
        kubernetes
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
