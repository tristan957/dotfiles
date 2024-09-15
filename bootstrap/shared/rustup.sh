function rustup_download() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
}

function rustup_add_components {
    rustup component add rust-src
}

function rustup_bash_completion {
    systemctl --user enable --now \
        cargo-bash-completion.path \
        rustup-bash-completion.path
}

function rustup_setup() {
    rustup_download
    rustup_add_components
    rustup_bash_completion
}
