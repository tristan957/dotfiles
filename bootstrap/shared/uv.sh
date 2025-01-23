function uv_enable_units() {
    systemctl --user enable --now \
        uv-bash-completion.path \
        uvx-bash-completion.path
}

function uv_install() {
    curl -LsSf https://astral.sh/uv/install.sh | sh -s -- --no-modify-path
}

function uv_setup() {
    uv_install
    uv_enable_units
}
