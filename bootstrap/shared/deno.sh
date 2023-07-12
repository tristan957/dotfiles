function deno_download() {
    curl -fsSL https://deno.land/x/install/install.sh | sh
}

function deno_completions() {
    deno completions bash >"${XDG_DATA_HOME}/bash-completion/completions/deno"
}

function deno_setup() {
    deno_download
    deno_completions
}
