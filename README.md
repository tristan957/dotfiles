# dotfiles

These are my personal configuration files.

## Solus Setup

Under `solus-setup`, I have a set of scripts to get some aspects of a new
install bootstrapped. It can be invoked by
`bash main.sh gtk_packages_list.txt`.

## GNU Stow

This repository uses GNU `stow` to manage `dotfiles`.

* bash
* solus
* ssh
* tmux
* vim

The above is a list of packages `stow` can be used on. That syntax looks like
`stow {package}`.

## Bash Prompt

![Bash Prompt](prompt.png?raw=true "Bash Prompt")

From left to right:

* return code of previous command
* 24-hr time
* username@computer
* current directory limited to 2 directories
* git branch marked with dirty state, new file, and push/pull state
