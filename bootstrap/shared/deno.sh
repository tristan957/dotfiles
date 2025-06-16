function deno_download {
    curl -fsSL https://deno.land/x/install/install.sh | sh
}

function deno_bash_completion {
    systemctl --user enable --now deno-bash-completion.path
    systemctl --user start deno-bash-completion.service
}

function deno_setup() {
    if ! comamnd -v deno &>/dev/null; then
        if [[ $WORK -eq 0 ]]; then
            deno_download
        fi
    fi

    if command -v systemctl &>/dev/null; then
        deno_bash_completion
    fi
}
