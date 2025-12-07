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

    # cloudflared
    # https://pkg.cloudflare.com/index.html#RHEL-generic
    curl -fsSl https://pkg.cloudflare.com/cloudflared-ascii.repo |
        sudo tee /etc/yum.repos.d/cloudflared.repo

    # Docker
    sudo dnf config-manager addrepo \
        --from-repofile='https://download.docker.com/linux/fedora/docker-ce.repo'

    # Gleam
    dnf copr enable --assumeyes frostyx/gleam

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

    # Google Cloud CLI (https://cloud.google.com/sdk/docs/install#rpm)
    echo '[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg' |
        sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo

    # Hashicorp
    sudo dnf config-manager addrepo --assumeyes \
        --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

    # Lazygit
    sudo dnf copr enable --assumeyes atim/lazygit

    # Microsoft
    curl -sSL -O "https://packages.microsoft.com/config/$distro/$version/packages-microsoft-prod.rpm"
    sudo rpm -i ./packages-microsoft-prod.rpm
    rm ./packages-microsoft-prod.rpm

    # Mullvad
    sudo dnf config-manager addrepo --assumeyes \
        --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo

    # RPM Fusion
    sudo dnf install --assumeyes \
        "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$version.noarch.rpm"
    sudo dnf install --assumeyes \
        "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$version.noarch.rpm"

    # Teleport
    sudo dnf config-manager addrepo --assumeyes \
        --from-repofile=https://rpm.releases.teleport.dev/teleport.repo

    # Terra
    sudo dnf install --nogpgcheck --repofrompath --assumeyes \
        'terra,https://repos.fyralabs.com/terra$releasever' terra-release

    # VSCode
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo '[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc' |
        sudo tee /etc/yum.repos.d/vscode.repo

    sudo dnf update --assumeyes @core
}

function dnf_remove_repos() {
    # Why does Fedora install this by default
    sudo dnf copr remove phracek/PyCharm
}

function dnf_install_packages() {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    xargs sudo dnf remove --assumeyes <<<"$(grep --extended-regexp --invert-match '^(#|$)' \
        "$dir/packages/remove.txt")"
    xargs sudo dnf install --assumeyes <<<"$(grep --extended-regexp --invert-match '^(#|$)' \
        "$dir/packages/install.txt")"
    xargs sudo dnf install --assumeyes <<<"$(grep --extended-regexp --invert-match '^(#|$)' \
        "$dir/packages/work.txt")"
}

# Proprietary codec bs
# https://rpmfusion.org/Howto/Multimedia
function dnf_proprietary_multimedia() {
    # Switch to the full ffmpeg
    sudo dnf swap --assumeyes ffmpeg-free ffmpeg --allowerasing

    # Install additional codecs
    sudo dnf update --assumeyes @multimedia \
        --setopt="install_weak_deps=False" \
        --exclude=PackageKit-gstreamer-plugin

    # Intel hardware accelerated codecs
    sudo dnf install --assumeyes intel-media-driver

    # AMD hardware accelerated codecs
    sudo dnf swap --assumeyes mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf swap --assumeyes mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

    # NVIDIA hardware accelerated codecs
    # I don't own NVIDIA, but if I did...
    # sudo dnf install libva-nvidia-driver

    # Play a DVD
    sudo dnf install --assumeyes rpmfusion-free-release-tainted
    sudo dnf install --assumeyes libdvdcss

    sudo dnf install --assumeyes rpmfusion-nonfree-release-tainted
    sudo dnf --repo=rpmfusion-nonfree-tainted install --assumeyes "*-firmware"
}

function dnf_setup() {
    dnf_add_repos
    dnf_remove_repos
    sudo dnf upgrade -y
    dnf_install_packages
    dnf_proprietary_multimedia
}
