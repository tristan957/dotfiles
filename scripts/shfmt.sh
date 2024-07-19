#!/bin/sh

files=$(find . -name "*.sh" -type f \
    -not -path "./rust/.opt/cargo/*")

# shellcheck disable=SC2086
shfmt --diff --language-dialect bash --indent 4 \
    bash/.bashrc \
    bash/.bash_logout \
    bash/.bash_profile \
    programs/.local/bin/gdbwait \
    $files
