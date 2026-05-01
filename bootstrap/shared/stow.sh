function stow_setup() {
    local dir=$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")
    pushd "$dir" &>/dev/null || exit

    local packages=(
        1password
        bash
        delta
        fish
        git
        helix
        jj
        neovim
        nix
        postgresql
        programs
        testcontainers
        vim
    )

    packages+=(
        desktop-database
        systemd
        tmpfiles
    )

    stow --restow "${packages[@]}"

    popd &>/dev/null || exit
}
