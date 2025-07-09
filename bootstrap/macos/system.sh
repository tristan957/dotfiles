function system_setup() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    . "$dir/defaults.sh"
    . "$dir/xcode.sh"

    defaults_setup
    xcode_setup
}
