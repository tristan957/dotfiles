# dotfiles

These are my personal configuration files.

## GNU Stow

This repository uses GNU `stow` to manage `dotfiles`.

* bash
* solus
* ssh
* tmux
* vim
* nvim
* terraform
* readline
* libedit
* yarn

The above is a list of packages `stow` can be used on. That syntax looks like
`stow {package}`.

## Bash Prompt

![Bash Prompt (insert)](prompt.png?raw=true "Bash Prompt")

From left to right:

* return code of previous command
* number of jobs currently managed by the shell
* 24-hr time
* username@hostname
* current directory
* git branch

2nd line:

* root/user
