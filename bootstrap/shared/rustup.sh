function rustup_download() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
}

function rustup_setup() {
    rustup_download

    rustup component add rust-src
}
