# Multi-user (daemon) installation
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish 2>/dev/null

# Single-user installation
source "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.fish" 2>/dev/null
