function flyctl_settings {
    flyctl settings autoupdate enable
}

function flyctl_download {
    curl -L https://fly.io/install.sh | sh
}

function flyctl_bash_completion {
    systemctl --user enable --now flyctl-bash-completion.path
    systemctl --user start flyctl-bash-completion.service

    # Setup bash-completion for the fly symlink
    pushd "$XDG_DATA_HOME/bash-completion/completions/" >/dev/null 2>&1 || return
    ln --symbolic --relative ./flyctl fly
    popd >/dev/null 2>&1 || return
}

function flyctl_setup {
    flyctl_download
    flyctl_settings
    flyctl_bash_completion
}
