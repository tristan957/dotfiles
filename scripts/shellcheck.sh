#!/bin/sh

files=$(find . -name "*.sh" -type f)

# shellcheck disable=SC2086
shellcheck --shell bash --source-path bash -x \
    modules/aerc/aerc-signature \
    modules/bash/bash_logout \
    modules/programs/dbgwait \
    $files
