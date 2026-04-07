function dnf_install_packages() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    xargs sudo dnf install --assumeyes <<<"$(grep --extended-regexp --invert-match '^(#|$)' \
        "$dir/packages/install.txt")"
}

function dnf_setup() {
    sudo dnf upgrade -y
    dnf_install_packages
}
