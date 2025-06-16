function rustup_download() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
}

function rustup_add_components {
    "$CARGO_HOME/bin/rustup" component add rust-src
}

function rustup_bash_completion {
    systemctl --user enable --now \
        cargo-bash-completion.path \
        rustup-bash-completion.path
    systemctl --user start \
        cargo-bash-completion.service \
        rustup-bash-completion.service
}

function rustup_setup() {
    if ! command -v rustup &>/dev/null; then
        rustup_download
    fi

    rustup_add_components

    if command -v systemctl &>/dev/null; then
        rustup_bash_completion
    fi
}
