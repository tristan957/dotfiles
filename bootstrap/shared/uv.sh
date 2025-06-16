function uv_enable_units() {
    systemctl --user enable --now \
        uv-bash-completion.path \
        uvx-bash-completion.path
}

function uv_install() {
    curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 -- \
        sh -s
}

function uv_setup() {
    if ! command -v uv &>/dev/null; then
        uv_install
    fi

    if command -v systemctl &>/dev/null; then
        uv_enable_units
    fi
}
