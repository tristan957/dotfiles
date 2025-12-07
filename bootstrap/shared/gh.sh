function gh_login {
    gh auth login --hostname github.com --web --git-protocol https
}

function gh_setup {
    if ! command -v gh &>/dev/null; then
        builtin return
    fi

    gh_login
}
