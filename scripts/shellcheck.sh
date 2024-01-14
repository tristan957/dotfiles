#!/bin/sh

files=$(find . -name "*.sh" -type f \
    -not -name "git-prompt.sh" \
    -not -path "./cargo/.opt/cargo/*")

# shellcheck disable=SC2086
shellcheck --shell bash --source-path bash -x bash/.bashrc $files
