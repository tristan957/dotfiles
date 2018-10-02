# dotfiles

These are my personal configuration files.

## Solus Setup

Under `solus-setup`, I have a set of scripts to get some aspects of a new
install bootstrapped. It can be invoked by
`bash main.sh gtk_packages_list.txt`.

## GNU Stow

This repository uses GNU `stow` to manage `dotfiles`.

* bash
* git
* solus
* vim

The above is a list of packages `stow` can be used on. That syntax looks like
`stow {package}`.
