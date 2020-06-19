test -e "${HOME}/.linuxbrew/bin/brew" && eval $(${HOME}/.linuxbrew/bin/brew shellenv)
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
test -e "${HOME}/.bashrc" && source "${HOME}/.bashrc"
if [ -e /home/tristan957/.nix-profile/etc/profile.d/nix.sh ]; then . /home/tristan957/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
