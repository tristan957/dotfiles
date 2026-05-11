#!/bin/sh

echo 'Updating root flake'
nix flake update --flake .

for flake in ./flakes/*/; do
	echo "Updating $(basename "$flake") flake"
	nix flake update --flake "$flake"
done
