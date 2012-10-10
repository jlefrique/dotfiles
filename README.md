Content
=======

This repository contains my dotfiles used to configure the softwares I like to
use. Hosting my dotfiles in a Git repository allows me to deploy them easily
across the machines I work on (home, work...) and to keep them centralized.

I use Xmonad as window manager, Vim as text editor, tmux as terminal
multiplexer, urxvt as terminal emulator, Zsh as shell and the excellent
dmenu as an application launcher, Vim file opener, and more...

These files contain tricks, tips and code snippets collected around the web.
Feel free to re-use (part of) them.


Installation
============

The files are stored in a separate folder and are symlinked to the home
directory.

Automatic
---------

    cd ~
    curl -s -k https://raw.github.com/jlefrique/dotfiles/master/install.sh | bash

Manual
------

Clone the repository:

    git clone https://jlefrique@github.com/jlefrique/dotfiles.git ~/dotfiles

Create symlinks:

    ln -s ~/dotfiles/vimrc ~/.vimrc
    ln -s ~/dotfiles/vim ~/.vim
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
    ...

Switch to the `~/dotfiles` directory, and fetch submodules:

    cd ~/dotfiles
    git submodule init
    git submodule update

Set zsh as your default shell, and restart your session:

    chsh -s /bin/zsh
