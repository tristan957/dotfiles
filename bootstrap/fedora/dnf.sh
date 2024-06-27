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

    # Grafana (https://rpm.grafana.com/)
    echo '[grafana]
name=Grafana
baseurl=https://rpm.grafana.com
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://rpm.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt' |
        sudo tee /etc/yum.repos.d/grafana.repo

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
        "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$version.noarch.rpm"
    sudo dnf install -y \
        "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$version.noarch.rpm"

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

    sudo dnf update -y @core
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
    # Switch to the full ffmpeg
    sudo dnf swap ffmpeg-free ffmpeg --allowerasing

    # Install additional codecs
    sudo dnf update @multimedia \
        --setopt="install_weak_deps=False" \
        --exclude=PackageKit-gstreamer-plugin
    sudo dnf update @sound-and-video

    # Intel hardware accelerated codecs
    sudo dnf install intel-media-driver

    # AMD hardware accelerated codecs
    sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

    # NVIDIA hardware accelerated codecs
    # I don't own NVIDIA, but if I did...
    # sudo dnf install libva-nvidia-driver

    # Play a DVD
    sudo dnf install rpmfusion-free-release-tainted
    sudo dnf install libdvdcss

    sudo dnf install rpmfusion-nonfree-release-tainted
    sudo dnf --repo=rpmfusion-nonfree-tainted install "*-firmware"
}

function dnf_setup() {
    dnf_add_repos
    sudo dnf upgrade -y
    dnf_install_packages
    dnf_proprietary_multimedia
}
