# Multi-user (daemon) installation
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 2>/dev/null

# Single-user installation
. "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.sh" 2>/dev/null
