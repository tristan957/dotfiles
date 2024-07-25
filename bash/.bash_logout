# This file is sourced when a login shell terminates.
# Clear the screen for security's sake.
if [ "$SHLVL" -eq 1 ]; then
    clear 2>/dev/null
fi
