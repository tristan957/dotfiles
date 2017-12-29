#!/usr/bin/env bash

# read the file and install packages
function install()
{
    $SUDO $package_manager $update_command
    $SUDO $package_manager $install_command -c system.devel # Solus specific

    programs=$(tr '\n' ' ' < $1)
    $SUDO $package_manager $install_command $programs
}

# get package manager info to be distroagnostic
function get_info()
{
    printf "Name of your package manager: "
    read -r package_manager
    # package_manager manager = "eopkg"
    printf "Update/Upgrade command for $package_manager: "
    read -r update_command
    # update_command = "up"
    printf "Install command for $package_manager: "
    read -r install_command
    # install_command = "it"
    printf "\n"
}
