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
    git clone https://github.com/jlefrique/dotfiles.git
    cd dotfiles
    ./install.sh

Manual
------

Clone the repository:

    cd ~
    git clone https://github.com/jlefrique/dotfiles.git

Create symlinks:

    ln -s ~/dotfiles/vimrc ~/.vimrc
    ln -s ~/dotfiles/vim ~/.vim
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
    ...

Switch to the `~/dotfiles` directory, and fetch submodules:

    cd ~/dotfiles
    git submodule init
    git submodule update


Finish up
=========

Set zsh as your default shell, and restart your session:

    chsh -s /bin/zsh

Fix screen's terminfo to display italic and standout correctly when tmux is
started in urxvt, and verify.

    tmux_terminfo.sh
    tmux
    font_test.sh

Note that there is no italic version of the Terminus font, therefore the font
is replaced for italic characters.

Set a wallpaper using feh:

    feh --bg-fill ~/wallpaper/my_wallpaper.png
