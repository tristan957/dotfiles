function dnf_add_repos() {
    distro=$(grep ^ID /etc/os-release | cut -d = -f 2)
    version=$(grep ^VERSION_ID /etc/os-release | cut -d = -f 2)

    # 1Password
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
    # shellcheck disable=SC2016
    echo '[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.1password.com/linux/keys/1password.asc' |
        sudo tee /etc/yum.repos.d/1password.repo

    # Charm
    echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' |
        sudo tee /etc/yum.repos.d/charm.repo

    # Hashicorp
    sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

    # Microsoft
    curl -sSL -O "https://packages.microsoft.com/config/$distro/$version/packages-microsoft-prod.rpm"
    sudo rpm -i ./packages-microsoft-prod.rpm
    rm ./packages-microsoft-prod.rpm

    # Mullvad
    sudo dnf config-manager --add-repo https://repository.mullvad.net/rpm/stable/mullvad.repo

    # RPM Fusion
    sudo dnf install -y \
        "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
    sudo dnf install -y \
        "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

    # Swift-MesonLSP
    sudo dnf copr enable -y jcwasmx86/Swift-MesonLSP

    # Teleport
    sudo dnf config-manager --add-repo https://rpm.releases.teleport.dev/teleport.repo

    # VSCode
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo '[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc' |
        sudo tee /etc/yum.repos.d/vscode.repo

    # VSCodium
    sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    echo '[vscodium]
name=VSCodium
baseurl=https://download.vscodium.com/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg' |
        sudo tee /etc/yum.repos.d/vscodium.repo

    sudo dnf group update -y core
}

function dnf_install_packages() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    xargs sudo dnf remove -y <"$dir/packages/remove.txt"
    xargs sudo dnf install -y <"$dir/packages/install.txt"
    xargs sudo dnf install -y <"$dir/work.txt"
}

# Proprietary codec bs
# https://rpmfusion.org/Howto/Multimedia
function dnf_proprietary_multimedia() {
    sudo dnf swap ffmpeg-free ffmpeg --allowerasing
    sudo dnf groupupdate multimedia \
        --setopt="install_weak_deps=False" \
        --exclude=PackageKit-gstreamer-plugin
    sudo dnf groupupdate sound-and-video
    # Intel
    sudo dnf install intel-media-driver
    # AMD
    sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    sudo dnf install rpmfusion-free-release-tainted
    sudo dnf install libdvdcss
}

function dnf_setup() {
    dnf_add_repos
    sudo dnf upgrade -y
    dnf_install_packages
    dnf_proprietary_multimedia
}
