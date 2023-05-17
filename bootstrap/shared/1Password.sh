function 1Password_completions {
    op completions bash > "${XDG_DATA_HOME}/bash-completion/completions/op"
}

function 1Password_setup {
    1password_completions
}
