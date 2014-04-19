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
