dir=$(dirname "${BASH_SOURCE[0]}")

function dconf_load {
    dconf load /org/gnome/calculator/ <"$dir/org/gnome/calculator/settings.ini"
    dconf load /org/gnome/desktop/ <"$dir/org/gnome/desktop/settings.ini"
    dconf load /org/gnome/epiphany/ <"$dir/org/gnome/epiphany/settings.ini"
    dconf load /org/gnome/nautilus/ <"$dir/org/gnome/nautilus/settings.ini"
    dconf load /org/gnome/settings-daemon/ <"$dir/org/gnome/settings-daemon/settings.ini"
    dconf load /org/gnome/shell/ <"$dir/org/gnome/shell/settings.ini"
    dconf load /org/gnome/system/ <"$dir/org/gnome/system/settings.ini"
    dconf load /org/gnome/terminal/ <"$dir/org/gnome/terminal/settings.ini"
    dconf load /org/gnome/TextEditor/ <"$dir/org/gnome/TextEditor/settings.ini"
    dconf load /org/gnome/tweaks/ <"$dir/org/gnome/tweaks/settings.ini"
    dconf load /org/gnome/Weather <"$dir/org/gnome/Weather/settings.ini"
}

function dconf_setup {
    dconf_load
}
