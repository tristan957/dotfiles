rust_init()
{
    curl https://sh.rustup.rs -sSf | sh
    $SUDO sh -c "rustup completions bash > /etc/bash_completion.d/rustup.bash-completion"
}