function flyctl_settings {
    flyctl settings autoupdate enable
}

function flyctl_download {
    curl -fsSL https://fly.io/install.sh | sh
}

function flyctl_bash_completion {
    systemctl --user enable --now flyctl-bash-completion.path
    systemctl --user start flyctl-bash-completion.service

    # Setup bash-completion for the fly symlink
    pushd "$XDG_DATA_HOME/bash-completion/completions/" >/dev/null 2>&1 || return
    ln --symbolic --relative ./flyctl fly
    popd >/dev/null 2>&1 || return
}

function flyctl_login {
    flyctl auth login
}

function flyctl_setup {
    if [[ $WORK -eq 1 ]]; then
        builtin return
    fi

    # If we already have it, we probably got it from a package manager or
    # previous bootstrap script invocation
    if ! command -v flyctl &>/dev/null; then
        flyctl_download
        flyctl_settings
    fi

    if command -v systemctl &>/dev/null; then
        flyctl_bash_completion
    fi

    flyctl_login
}
