function deno_download {
    curl -fsSL https://deno.land/x/install/install.sh | sh
}

function deno_bash_completion {
    systemctl --user enable --now deno-bash-completion.path
    systemctl --user start deno-bash-completion.service
}

function deno_setup() {
    deno_download
    deno_bash_completion
}
