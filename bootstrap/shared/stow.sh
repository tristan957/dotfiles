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
        clangd
        comlink
        containers
        delta
        dir_colors
        direnv
        dotnet
        editline
        fish
        fzf
        gdb
        ghostty
        git
        glow
        harper
        helix
        hut
        jj
        kubernetes
        lazygit
        man
        meson
        mjmap
        neovim
        nix
        postgresql
        programs
        testcontainers
        tmux
        uv
        vim
        xdg
        zoxide
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
