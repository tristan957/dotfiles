function gh_login {
    gh auth login --hostname github.com --web --git-protocol https
}

function gh_setup {
    gh_login
}
