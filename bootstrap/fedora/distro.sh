dir=$(dirname "${BASH_SOURCE[0]}")

. "$dir/dnf.sh"

function distro_setup() {
    dnf_setup
}
