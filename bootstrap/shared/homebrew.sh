function homebrew_add_taps() {
    brew tap ampcode/tap/amp
    brew tap databricks/tap
    brew tap oven-sh/bun
    brew tap rockorager/tap
}

function homebrew_install_packages() {
    local dir=$(dirname "${BASH_SOURCE[0]}")
    local packages="$dir/homebrew/macos.txt"

    xargs brew install <<<"$(grep --extended-regexp --invert-match '^(#|$)' \
        "$packages")"
}

function homebrew_install() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function homebrew_setup() {
    if [[ $IS_MACOS -eq 0 ]]; then
        return
    fi

    if ! command -v brew &>/dev/null; then
        homebrew_install
    fi

    homebrew_add_taps
    homebrew_install_packages

    brew cleanup
}
