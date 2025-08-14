loginctl enable-linger

# Please arca, stop it
git -C "$HOME/dotfiles" restore \
    bash/.bashrc \
    git/.config/git/config \
    zsh/.zshrc
mv "$HOME/.ssh/config" "$HOME/.ssh/config.old"
sed '/^Include/d' < "$HOME/.ssh/config.old" > "$HOME/.ssh/config"

HISTFILE="${XDG_STATE_HOME:-$HOME/.var}/zsh/history"
HISTSIZE=1000000

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    exec env SHELL="$(which bash)" bash
else
    exec env SHELL="$(which bash)" tmux -f "${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
fi
