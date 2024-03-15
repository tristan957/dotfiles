function github_login {
    gh auth login --hostname github.com --web --git-protocol https
}

function github_setup {
    github_login
}
