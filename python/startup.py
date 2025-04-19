from __future__ import annotations

import atexit
import os
import readline

HOME = os.getenv("HOME")
assert HOME

STATE_DIR = os.getenv("XDG_STATE_HOME", os.path.join(HOME, ".var"))
PYTHON_STATE_DIR = os.path.join(STATE_DIR, "python")
HISTFILE = os.path.join(PYTHON_STATE_DIR, "history")

os.makedirs(PYTHON_STATE_DIR, mode=755, exist_ok=True)

try:
    readline.read_history_file(HISTFILE)
    h_len = readline.get_current_history_length()
except FileNotFoundError:
    open(HISTFILE, 'wb').close()
    h_len = 0

def save(prev_h_len: int, histfile: None | bytes | os.PathLike[bytes] | str | os.PathLike[str]):
    new_h_len = readline.get_current_history_length()
    readline.set_history_length(1000)
    readline.append_history_file(new_h_len - prev_h_len, histfile)

atexit.register(save, h_len, HISTFILE)
