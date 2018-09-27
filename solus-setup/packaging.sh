#!/usr/bin/env bash

# set up Solus packaging environment
function packaging_setup()
{
    cd ~/Projects/
    mkdir Solus-Packaging
    cd Solus-Packaging
    git clone https://dev.getsol.us/source/common.git
    ln -sv common/Makefile.common .
    ln -sv common/Makefile.toplevel Makefile
    ln -sv common/Makefile.iso .

    solbuild init -u -p unstable-x86_64
    solbuild init -u -p main-x86_64

    arc set-config default https://dev.getsol.us
    arc install-certificate
    cd ~
}
