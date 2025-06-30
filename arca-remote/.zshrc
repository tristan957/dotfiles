loginctl enable-linger

# Please arca, stop it
git -C "$HOME/dotfiles" restore git/.config/git/config

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
	exec env SHELL="$(which bash)" bash
else
	exec env SHELL="$(which bash)" tmux -f "${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
fi
