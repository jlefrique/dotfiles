Packages
========

The first package to install is etckeeper. This allows to keep track of the
modifications of /etc.

    sudo apt-get install etckeeper

Then, choose git as VCS in /etc/etckeeper/etckeeper.conf and initialize
etckeeper:

    sudo etckeeper init

Finally, install all the other packages:

    sudo apt-get install $(cat packages)


NFS shares
==========

Install autofs and add the following line to /etc/auto.master:

    /net  /etc/auto.net

Then restart autofs:

    sudo service autofs reload
    sudo service autofs restart


usb-serial converters
=====================

To access /dev/ttyUSBx, add your user to the group dialout:

    sudo adduser jlefrique dialout


LaTeX packages
==============

To install custom LaTeX packages, create the following directory:

    mkdir -p $HOME/texmf/tex/latex

Add your custom packages:

    cd $HOME/texmf/tex/latex
    git clone git@github.com:jlefrique/moderncv.git

Run texhash. This will create a database of files inside your texmf directory:

    texhash $HOME/texmf

Whenever you add new files to your texmf tree, be sure to run texhash.
