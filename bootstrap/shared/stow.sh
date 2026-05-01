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
        helix
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

    packages+=(
        desktop-database
        ptyxis
        systemd
        tmpfiles
    )

    stow --restow "${packages[@]}"

    popd &>/dev/null || exit
}
