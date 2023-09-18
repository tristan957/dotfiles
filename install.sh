#!/usr/bin/env bash

set -u
set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

if ! type stow >/dev/null 2>&1; then
    echo "stow is not installed" >&2
    exit 1
fi

packages=()
dry_run=0

while getopts ":dp:" o; do
    case $o in
    d) dry_run=1 ;;
    p) packages+=("$OPTARG") ;;
    :)
        echo "'$1' requires an argument" >&2
        exit 1
        ;;
    ?)
        echo "Unknown flag '$1'" >&2
        exit 1
        ;;
    esac
done

if [ "${#packages[@]}" -eq 0 ]; then
    packages+=("aerc" "bash" "bat" "cargo" "clangd" "gdb" "git" "less" "libedit" "npm" "nvim" "programs" "psql" "readline" "terraform" "tmux" "vim" "yarn")
fi

for p in "${packages[@]}"; do
    if [ $dry_run -eq 1 ]; then
        echo Installing "$p" "(dry run)"
        stow --no --dir "$SCRIPT_DIR" --restow "$p" 2>/dev/null
    else
        echo Installing "$p"
        stow --dir "$SCRIPT_DIR" --restow "$p"
    fi
    status=$?
    if [ $status -ne 0 ]; then
        exit $status
    fi
done
