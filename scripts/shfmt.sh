#!/bin/sh

files=$(find . -name "*.sh" -type f \
    -not -name "git-prompt.sh" \
    -not -path "./cargo/.opt/cargo/*")

# shellcheck disable=SC2086
shfmt --diff --language-dialect bash --indent 4 programs/.local/bin/gdbwait $files
