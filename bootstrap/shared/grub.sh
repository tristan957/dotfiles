function grub_setup {
    # Always show the GRUB menu
    sudo grub2-editenv - unset menu_auto_hide
}
