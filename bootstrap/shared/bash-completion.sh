function bash_completion_install() {
    rustup completions bash cargo >"${XDG_DATA_HOME}/bash-completion/completions/cargo"
    rustup completions bash rustup >"${XDG_DATA_HOME}/bash-completion/completions/rustup"
}

function bash_completion_setup() {
    bash_completion_install
}
