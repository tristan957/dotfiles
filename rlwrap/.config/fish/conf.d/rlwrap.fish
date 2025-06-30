# I would love to keep history in XDG_STATE_HOME, but completions belong in
# XDG_DATA_HOME.
set -gx RLWRAP_HOME "$XDG_DATA_HOME/rlwrap"
