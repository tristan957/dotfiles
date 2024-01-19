#!/bin/sh

files=$(find . -name "*.py" -type f)

# shellcheck disable=SC2086
ruff check --diff \
    programs/.local/bin/chcompdb \
    programs/.local/bin/xdp-file-chooser \
    $files
