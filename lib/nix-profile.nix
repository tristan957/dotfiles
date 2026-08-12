# Snippets that source the Nix profile from a login shell.
#
# The single- and multi-user installers put the profile script in different
# places, and Fedora ships it somewhere else again, so all candidates are tried
# and the failures ignored. Shared by the bash, zsh and fish modules so the
# three cannot drift apart.
{
  # POSIX shell syntax, used by both bash and zsh.
  posix = ''
    # Nix
    # Multi-user (daemon) installation
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 2>/dev/null
    # Fedora
    . /etc/profile.d/nix-daemon.sh 2>/dev/null
    # Single-user installation
    . "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.sh" 2>/dev/null
  '';

  fish = ''
    # Nix
    # Multi-user (daemon) installation
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish 2>/dev/null
    # Fedora
    source /etc/profile.d/nix-daemon.fish 2>/dev/null
    # Single-user installation
    source "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.fish" 2>/dev/null
  '';
}
