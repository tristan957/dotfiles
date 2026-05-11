#!/bin/sh

echo 'Updating root flake'
nix flake update --flake .

echo 'Updating work flake'
nix flake update --flake ./flakes/work
