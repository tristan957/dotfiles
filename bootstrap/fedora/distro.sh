function distro_setup() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    . "$dir/dnf.sh"

    dnf_setup
}
