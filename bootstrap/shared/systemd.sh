function systemd_enable() {
	systemd --user enable --now tmux
}

function systemd_setup() {
	systemd_enable
}
