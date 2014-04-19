Packages
========

The first package to install is etckeeper. This allows to keep track of the
modifications of /etc.

    sudo apt-get install etckeeper

Then, choose git as VCS in /etc/etckeeper/etckeeper.conf and initialize
etckeeper:

    sudo etckeeper init

Finally, install all the other packages:

    sudo apt-get install $(cat $HOME/dotfiles/packages/packages)


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

Using Ikiwiki with git requires an additional "working" repository in addition
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

mpd can be configured per user:

    ln -s $HOME/dotfiles/mpdconf $HOME/.mpdconf
    mkdir -p $HOME/.mpd/playlists
    touch $HOME/.mpd/{database,log,pid,state}

Then start or restart mpd.
