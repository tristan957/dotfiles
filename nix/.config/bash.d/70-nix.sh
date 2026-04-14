if [[ -z "$__NIX_SOURCED" ]] && [[ -f "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.sh" ]]; then
    export __NIX_SOURCED=1
    . "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.sh" 2>/dev/null
fi
