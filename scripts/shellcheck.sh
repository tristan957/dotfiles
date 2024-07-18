#!/bin/sh

files=$(find . -name "*.sh" -type f \
    -not -path "./rust/.opt/cargo/*")

# shellcheck disable=SC2086
shellcheck --shell bash --source-path bash -x bash/.bashrc $files
