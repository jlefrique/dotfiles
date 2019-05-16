Packages
========

The first package to install is etckeeper. This allows to keep track of the
modifications of /etc.

    sudo apt-get install etckeeper

Then, choose git as VCS in /etc/etckeeper/etckeeper.conf and initialize
etckeeper:

    sudo etckeeper init

Finally, install all the other packages:

    sudo apt-get install $(cat $HOME/dotfiles/packages/packages_list.txt)


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


Wiki
====

Clone the source of the wiki. This will be the working copy to edit:

    cd $HOME/git
    git clone /net/willow/git/jlefrique-wiki.git

Using Ikiwiki with git requires an additional working repository in addition
to the one that committers push to.

    sudo mkdir -p /var/lib/ikiwiki
    sudo chown -R jlefrique:jlefrique /var/lib/ikiwiki
    cd /var/lib/ikiwiki
    git clone /net/willow/git/jlefrique-wiki.git

Clone the repository that will contain the html output. This part is required
only if you want to host the html output on Github pages:

    cd $HOME/git
    git clone git@github.com:jlefrique/jlefrique.github.com.git

Run the setup file:

    ikiwiki --setup ~/git/jlefrique-wiki/jlefrique-wiki.setup


Music Player Daemon
===================

Prevent mpd to start as a system daemon. mpd will be started in .xsession:

    sudo service mpd stop and
    sudo update-rc.d mpd disable

Configure mpd per user:

    ln -s $HOME/dotfiles/mpdconf $HOME/.mpdconf
    mkdir -p $HOME/.mpd/playlists
    touch $HOME/.mpd/{database,log,pid,state}

Then start or restart mpd.


Android SDK
===========

For Debian Jessie, ia32-libs is not available anymore.

    sudo apt-get install lib32z1 lib32ncurses5 lib32stdc++6


Java Development Kit
====================

To install another JDK (e.g. Oracle JDK), extract your JDK in /opt/java. Then
update alternatives:

    sudo update-alternatives --install /usr/bin/java java /opt/java/jdk1.6.0_45/bin/java 1500
    sudo update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.6.0_45/bin/javac 1500

Check with those commands:

    update-alternatives --display java
    update-alternatives --display javac

To switch between JDK versions:

    sudo update-alternatives --config java
    sudo update-alternatives --config javac


Downgrade make
==============

To build Android, make 3.81 or 3.82 is required.

Add the following repository to /etc/apt/sources.list:

    deb http://ftp.ch.debian.org/debian stable main

Then, install the package:

    sudo apt-get update
    apt-cache show make
    sudo apt-get install make/stable


Mark the package as held:

    sudo apt-mark hold make

Remove the stable repository from /etc/apt/sources.list and update again.

To show or remove held packages:

    apt-mark showhold
    sudo apt-mark unhold make


Network scanner
===============

Edit /etc/sane.d/xerox_mfp.conf and add the following lines:

    #Samsung C460 over network
    tcp 192.168.1.15


Multi-arch
==========

To add foreign architectures:

    sudo dpkg --add-architecture i386
    sudo dpkg --add-architecture armhf


Root
====

To activate root account:

    sudo passwd root


Git submodules
==============

Add a new submobule:

    git submodule add git://github.com/tpope/vim-fugitive.git vim/bundle/vim-fugitive

Pull all submodules to the lastest revision of master:

    git submodule foreach git pull origin master


Pinentry
========

Add this to ~/.gnupg/gpg.conf:

    use-agent
    pinentry-mode loopback

And add this to ~/.gnupg/gpg-agent.conf, creating the file if it doesn't already
exist:

    allow-loopback-pinentry
