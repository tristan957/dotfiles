if [[ -v HOMEBREW_PREFIX ]]; then
    . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" 2>/dev/null
fi

if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion 2>/dev/null
fi

# shellcheck disable=SC2034
# GIT_COMPLETION_SHOW_ALL_COMMANDS=1
# shellcheck disable=SC2034
GIT_COMPLETION_SHOW_ALL=1
# shellcheck disable=SC2034
GIT_COMPLETION_IGNORE_CASE=1
