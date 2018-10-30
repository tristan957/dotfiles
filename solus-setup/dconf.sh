dconf_load()
{
    cd $HOME/dotfiles/solus-setup
    dconf load /com/gexperts/Tilix/ < dconf/tilix.dconf
    dconf load /org/gnome/gedit/ < dconf/gedit.dconf
    dconf load /org/gnome/terminal/legacy/ < dconf/gnome-terminal.dconf
    dconf load /org/gnome/nautilus/ < dconf/nautilus.dconf
}
