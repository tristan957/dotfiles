if not set -q __NIX_SOURCED
    set -gx __NIX_SOURCED 1
    source "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.fish" 2>/dev/null
end
