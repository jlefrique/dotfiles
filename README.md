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

Where bash is used instead (e.g. root shells or other machines), get a prompt
with the same information by sourcing it from `~/.bashrc`:

    echo '[ -f ~/dotfiles/bash/prompt.bash ] && . ~/dotfiles/bash/prompt.bash' >> ~/.bashrc

Fix screen's terminfo to display italic and standout correctly when tmux is
started in urxvt, and verify.

    tmux_terminfo.sh
    tmux
    font_test.sh

Then do the same as root:

    sudo -s
    tmux_terminfo.sh

Note that the Terminus font has no true italic, but the `fonts-terminus-otb`
package provides an oblique style that is used for italic characters.

Install alacritty's upstream terminfo entries in `~/.terminfo`, and verify.

    alacritty_terminfo.sh
    infocmp alacritty-direct

Install the Terminess Nerd Font used by alacritty. It provides the Nerd Font
icons used by nvim plugins such as octo.nvim and nvim-web-devicons.

    terminess_font.sh
    fc-list | grep TerminessNerdFont

The nvim configuration needs Neovim 0.12 or later. Check the installed
version, and if it is older, install a release from
https://github.com/neovim/neovim/releases instead.

    nvim --version | head -1

Install the tools the nvim configuration uses. Telescope needs ripgrep and fd,
the tmux copy command needs xclip, and the treesitter parsers need a C compiler.

    sudo apt install ripgrep fd-find xclip build-essential curl

Install Rust with rustup, since the Ubuntu toolchain is too old, then
tree-sitter-cli to build the treesitter parsers, and alacritty.

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev \
        libxcb-xfixes0-dev libxkbcommon-dev python3
    cargo install --locked tree-sitter-cli alacritty

Install Node.js with nvm for copilot.lua and mcp-hub. `PROFILE=/dev/null`
stops the nvm installer from appending to `~/.zshrc`, which already sets up
nvm.

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | PROFILE=/dev/null bash
    nvm install --lts
    npm install -g mcp-hub@latest

Optionally, install tiktoken_core for exact token counts in CopilotChat.

    sudo apt install luarocks
    luarocks install --local --lua-version 5.1 tiktoken_core

Start nvim to install the plugins, the treesitter parsers and, through Mason,
the language servers.

To update the plugins later, run the command below in nvim, review the changes
in the buffer that opens and write it with `:w` to apply them. Then restart
nvim and rebuild the treesitter parsers, which must match the updated
nvim-treesitter queries.

    :lua vim.pack.update()
    :TSUpdate

Set a wallpaper using feh:

    feh --bg-fill ~/wallpaper/my_wallpaper.png
