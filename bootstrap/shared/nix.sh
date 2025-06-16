function nix_install {
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
}

function nix_setup {
    if [[ $WORK -eq 1 ]]; then
        builtin return
    fi

    nix_install
}
