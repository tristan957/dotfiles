# ipython can die in a hole for this: https://github.com/ipython/ipython/pull/4457
set -gx IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -gx JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
