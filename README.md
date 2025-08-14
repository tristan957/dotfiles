<!-- markdownlint-disable-next-line MD041 -->
[![builds.sr.ht status](https://builds.sr.ht/~tristan957/dotfiles.svg)](https://builds.sr.ht/~tristan957/dotfiles?)

# dotfiles

These are my personal configuration files.

## GNU Stow

This repository uses GNU `stow` to manage `dotfiles`.

- 1password
- aerc
- arca-host (Databricks)
- arca-remote (Databricks)
- asdf
- bash
- bat
- cargo
- clangd
- comlink
- containers
- deno
- desktop-database
- dir_colors
- direnv
- dotnet
- editline
- electron
- fish
- flyctl
- fzf
- gdb
- gh
- ghostty
- git
- glab
- glow
- go
- harper
- helix
- homebrew
- hut
- info
- jq
- jupyter
- kubernetes
- lazygit
- less
- man
- meson
- mise
- mjmap
- neon
- neovim
- nix
- nnn
- node
- npm
- nvm
- pgrx
- postgresql
- programs
- ptyxis
- python
- readline
- ripgrep
- rlwrap
- rustup
- ssh
- sway
- systemd
- teleport
- terraform
- testcontainers
- tmpfiles
- tmux
- toolbox
- uv
- vim
- vscodium
- xdg
- yarn
- zoxide

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
