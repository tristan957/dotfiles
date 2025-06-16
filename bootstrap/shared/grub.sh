function grub_setup {
    if ! command -v grub2-editenv &>/dev/null; then
        return
    fi

    # Always show the GRUB menu
    sudo grub2-editenv - unset menu_auto_hide
}
