dir=$(dirname "${BASH_SOURCE[0]}")

function dnf_add_repos() {
    # Hashicorp
    sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

    # RPM Fusion
    sudo dnf install -y \
       "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
    sudo dnf install -y \
       "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

    # VSCode
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

    # Microsoft
    curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

    sudo dnf group update -y core
}

function dnf_install_packages() {
    xargs sudo dnf install -y < "$dir/packages.txt"
}

function dnf_setup() {
    dnf_add_repos
    sudo dnf upgrade -y
    dnf_install_packages
}
