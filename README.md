Installation
============

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
