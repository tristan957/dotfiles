#!/bin/sh

echo 'Checking root flake'
nix flake check

for flake in ./flakes/*/; do
    flake="$(basename "$flake")"
    if [ "$flake" = work ]; then
        continue
    fi

    cd "flakes/$flake" || exit
    echo "Checking $flake flake"
    nix flake check
done
