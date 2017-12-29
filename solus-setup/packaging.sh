#!/usr/bin/env bash

# set up Solus packaging environment
function packaging_setup()
{
    # cd ~
    # mkdir .solus
    # cp ~/.TP-config/misc/packager ~/.solus
    # $SUDO solbuild init -u

    cd ~/Projects/
    mkdir Solus-Packaging
    cd Solus-Packaging
    git clone https://dev.solus-project.com/source/common.git
    ln -sv common/Makefile.common .
    ln -sv common/Makefile.toplevel Makefile
    ln -sv common/Makefile.iso .

    # arc set-config default https://dev.solus-project.com
    # arc install-certificate
    #
    # cp ~/.TP-config/misc/arcrc ~/.arcrc
    # chmod 600 ~/.arcrc
    cd ~
}
