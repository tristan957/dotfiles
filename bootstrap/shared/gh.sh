function gh_login {
    gh auth login --hostname github.com --web --git-protocol https
}

function gh_bash_completion {
    systemctl --user enable --now gh-bash-completion.path
    systemctl --user start gh-bash-completion.service
}

function gh_setup {
    if ! command -v gh &>/dev/null; then
        builtin return
    fi

    gh_login

    if command -v systemctl &>/dev/null; then
        gh_bash_completion
    fi
}
