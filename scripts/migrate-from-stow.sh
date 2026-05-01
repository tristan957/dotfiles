#!/bin/sh

# Remove stale symlinks left behind by stow after migrating to home-manager
find "$HOME" -maxdepth 1 -type l ! -exec test -e {} \; -delete -print
find "${XDG_CONFIG_HOME:-$HOME/.config}" -type l ! -exec test -e {} \; -delete -print
find "${XDG_DATA_HOME:-$HOME/.local/share}" -type l ! -exec test -e {} \; -delete -print
find "$HOME/.local/bin" -type l ! -exec test -e {} \; -delete -print 2>/dev/null
find "$HOME/.opt" -type l ! -exec test -e {} \; -delete -print 2>/dev/null
find "$HOME/.ssh" -type l ! -exec test -e {} \; -delete -print 2>/dev/null

# Clean up empty directories left behind
find "${XDG_CONFIG_HOME:-$HOME/.config}" -type d -empty -delete 2>/dev/null
find "${XDG_DATA_HOME:-$HOME/.local/share}" -type d -empty -delete 2>/dev/null
find "$HOME/.local/bin" -type d -empty -delete 2>/dev/null
