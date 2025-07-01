function system_setup() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    . "$dir/xcode.sh"

    xcode_setup
}
