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
        deno
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
        grep
        go
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
        mise
        mjmap
        neovim
        nnn
        node
        npm
        nvm
        pgrx
        postgresql
        programs
        python
        readline
        ripgrep
        rlwrap
        rustup
        terraform
        testcontainers
        tmux
        uv
        vim
        vscodium
        xdg
        yarn
        zoxide
    )

    if [[ $IS_MACOS -eq 1 ]]; then
        packages+=(
            homebrew
        )
    else
        packages+=(
            desktop-database
            electron
            flyctl
            ptyxis
            systemd
            tmpfiles
            toolbox
        )
    fi

    if [[ $WORK -eq 1 ]]; then
        packages+=(
            neon
            teleport
        )
    else
        packages+=(
            glab
            nix
            ssh
        )
    fi

    stow --restow "${packages[@]}"

    popd &>/dev/null || exit
}
