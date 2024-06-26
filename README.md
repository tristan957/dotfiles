<!-- prettier-ignore-start -->

<!-- markdownlint-disable-next-line MD041 -->
[![builds.sr.ht status](https://builds.sr.ht/~tristan957/dotfiles.svg)](https://builds.sr.ht/~tristan957/dotfiles?)

<!-- prettier-ignore-end -->

# dotfiles

These are my personal configuration files.

## GNU Stow

This repository uses GNU `stow` to manage `dotfiles`.

- 1password
- aerc
- alacritty
- bash
- bat
- clangd
- deno
- difftastic
- dir_colors
- dotnet
- editline
- electron
- foot
- gdb
- ghostty
- git
- glow
- go
- jq
- jupyter
- kubernetes
- less
- meson
- neon
- neovim
- nix
- nnn
- nodejs
- postgresql
- programs
- python
- readline
- ripgrep
- rust
- ssh
- sway
- systemd
- teleport
- terminfo
- terraform
- tmux
- vim
- vscodium
- wget
- xdg

The above is a list of packages `stow(8)` can be used on. That syntax looks like
`stow {package}`.

## Terminal

![Terminal with bash and tmux running to showcase style](terminal.png "Terminal")

### Bash

`PS0` from left to right:

- return code of previous command
- number of jobs currently managed by the shell
- 24-hr time
- username@hostname
- current directory
- git branch

2nd line:

- root/user (`#` or `$`)

### tmux

Statusline from left to right:

- session
- window list
  - current window
  - random window
  - last window
- hostname
- date
- 24-hr time
