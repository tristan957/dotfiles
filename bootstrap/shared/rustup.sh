function rustup_download() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
}

function rustup_completions() {
    rustup completions bash cargo >"${XDG_DATA_HOME}/bash-completion/completions/cargo"
    rustup completions bash rustup >"${XDG_DATA_HOME}/bash-completion/completions/rustup"
}

function rustup_setup() {
    rustup_download
    rustup_completions

    rustup component add rust-src
}
