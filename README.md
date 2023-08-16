[![builds.sr.ht status](https://builds.sr.ht/~tristan957/dotfiles.svg)](https://builds.sr.ht/~tristan957/dotfiles?)

# dotfiles

These are my personal configuration files.

## GNU Stow

This repository uses GNU `stow` to manage `dotfiles`.

- aerc
- alacritty
- bash
- bat
- cargo
- foot
- gdb
- git
- less
- libedit
- npm
- nvim
- programs
- readline
- ssh
- sway
- teleport
- terraform
- tmux
- vim
- yarn

The above is a list of packages `stow(8)` can be used on. That syntax looks like
`stow {package}`.

## Bash Prompt

![Bash Prompt (insert)](prompt.png?raw=true "Bash Prompt")

From left to right:

- return code of previous command
- number of jobs currently managed by the shell
- 24-hr time
- username@hostname
- current directory
- git branch

2nd line:

- root/user
