function dconf_load {
    local dir=$(dirname "${BASH_SOURCE[0]}")

    dconf load /org/gnome/calculator/ <"$dir/dconf/org/gnome/calculator/settings.ini"
    dconf load /org/gnome/desktop/ <"$dir/dconf/org/gnome/desktop/settings.ini"
    dconf load /org/gnome/epiphany/ <"$dir/dconf/org/gnome/epiphany/settings.ini"
    dconf load /org/gnome/nautilus/ <"$dir/dconf/org/gnome/nautilus/settings.ini"
    dconf load /org/gnome/settings-daemon/ <"$dir/dconf/org/gnome/settings-daemon/settings.ini"
    dconf load /org/gnome/shell/ <"$dir/dconf/org/gnome/shell/settings.ini"
    dconf load /org/gnome/system/ <"$dir/dconf/org/gnome/system/settings.ini"
    dconf load /org/gnome/terminal/ <"$dir/dconf/org/gnome/terminal/settings.ini"
    dconf load /org/gnome/TextEditor/ <"$dir/dconf/org/gnome/TextEditor/settings.ini"
    dconf load /org/gnome/tweaks/ <"$dir/dconf/org/gnome/tweaks/settings.ini"
    dconf load /org/gnome/Weather/ <"$dir/dconf/org/gnome/Weather/settings.ini"

    dconf load /org/gtk/Settings/ <"$dir/dconf/org/gtk/settings.ini"
    dconf load /org/gtk/gtk4/Settings/ <"$dir/dconf/org/gtk/gtk4/settings.ini"
}

function dconf_setup {
    if ! command -v dconf &>/dev/null; then
        return
    fi

    dconf_load
}
