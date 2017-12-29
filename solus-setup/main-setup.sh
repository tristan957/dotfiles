#!/usr/bin/env bash

source bash-setup.sh # bash_setup
source git-setup.sh # git_setup
source package-setup.sh # get_info, install
source packaging-setup.sh # packaging_setup

main()
{
    if [[ $EUID -ne 0 ]]; then # if not being run as root
        FILE=$1 # set file equal to first command line arg
        if [ -f $FILE ]; then # if file exists
            SUDO="sudo"
            get_info
            install $FILE
            git_setup
            # bash_setup
            packaging_setup
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
