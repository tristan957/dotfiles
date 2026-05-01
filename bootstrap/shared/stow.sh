function stow_setup() {
    local dir=$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")
    pushd "$dir" &>/dev/null || exit

    local packages=(
        1password
        aerc
        asdf
        bash
        bat
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
        glab
        glow
        harper
        helix
        hut
        info
        jj
        jq
        jupyter
        kubernetes
        lazygit
        less
        man
        meson
        mjmap
        neovim
        nix
        pgrx
        postgresql
        programs
        readline
        ripgrep
        rlwrap
        testcontainers
        tmux
        uv
        vim
        vscodium
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
            flyctl
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
