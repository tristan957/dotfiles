#!/bin/sh

# clangd
ln --symbolic --force \
    "$(realpath clangd/.config/clangd)" \
    "$HOME/Library/Preferences/clangd"
