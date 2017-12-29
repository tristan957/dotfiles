#!/usr/bin/env bash

source dconf.sh # dconf_load
source git.sh # git_setup
source install_packages.sh # get_info, install
source packaging.sh # packaging_setup
source rust.sh # rust_init
source stow.sh

main()
{
    if [[ $EUID -ne 0 ]]; then # if not being run as root
        FILE=$1 # set file equal to first command line arg
        if [[ -f $FILE ]]; then # if file exists
            SUDO="sudo"
            mkdir ~/Projects
            get_info
            install $FILE
            git_setup
            packaging_setup
            dconf_load
            rust_init
            gnu_stow
        else
            echo "Error: File does not exist."
            exit 2
        fi
    else
        echo "Don't run this script as root!"
        exit 1
    fi
    exit 0
}

main "$@"
