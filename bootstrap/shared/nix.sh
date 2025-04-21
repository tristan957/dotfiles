function nix_install {
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
}

function nix_setup {
    nix_install
}
