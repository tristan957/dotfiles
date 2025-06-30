set -gx PYTHON_HISTORY "$XDG_STATE_HOME/python/history"
# Python virtual environments should stop messing with PS1
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
