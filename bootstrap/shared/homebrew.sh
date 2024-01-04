function homebrew_install_packages() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    xargs brew install <"$dir/homebrew/packages.txt"
}

function homebrew_setup() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    homebrew_install_packages
}
