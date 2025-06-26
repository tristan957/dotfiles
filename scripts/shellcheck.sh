#!/bin/sh

files=$(find . -name "*.sh" -type f)

# shellcheck disable=SC2086
shellcheck --shell bash --source-path bash -x \
    aerc/.local/bin/aerc-signature \
    bash/.bashrc \
    bash/.bash_logout \
    bash/.bash_profile \
    programs/.local/bin/dbgwait \
    $files
