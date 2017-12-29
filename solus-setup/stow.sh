gnu_stow()
{
    cd ~/dotfiles/
    gpg --output arc/.arcrc -d arc/.arcrc.gpg
    stow arc
    stow bash
    stow git
    stow solus
    cd ssh/.ssh/
    gpg --output vpn_keys.tar.gz -d vpn_keys.tar.gz.gpg
    tar xzf vpn_keys.tar.gz
    cd ~/dotfiles
    stow ssh
    stow vim
}