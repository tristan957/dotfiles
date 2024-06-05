function dnf_add_repos() {
    # 1Password
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
    sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'

    # Charm
    echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo

    # Hashicorp
    sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

    # Microsoft
    curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

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
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

    # VSCodium
    sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    sudo sh -c 'printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=VSCodium\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" > /etc/yum.repos.d/vscodium.repo'

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
