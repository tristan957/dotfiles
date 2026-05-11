#!/bin/sh

files=$(find . -name "*.sh" -type f)

# shellcheck disable=SC2086
shfmt --case-indent --diff --language-dialect bash --indent 4 \
    modules/aerc/aerc-signature \
    modules/bash/bash_logout \
    modules/programs/dbgwait \
    $files
