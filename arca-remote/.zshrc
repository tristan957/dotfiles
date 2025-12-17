loginctl enable-linger

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_DIRS"
export XDG_STATE_HOME="$HOME/.var"

# Please arca, stop it
git -C "$HOME/dotfiles" restore \
    arca-remote/.zshrc \
    bash/.bashrc \
    git/.config/git/config
mv "$HOME/.ssh/config" "$HOME/.ssh/config.old"
sed '/^Include/d' < "$HOME/.ssh/config.old" > "$HOME/.ssh/config"

HISTFILE="${XDG_STATE_HOME:-$HOME/.var}/zsh/history"
HISTSIZE=1000000

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    exec env SHELL="$(which bash)" bash
else
    exec env SHELL="$(which bash)" tmux -f "${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
fi
