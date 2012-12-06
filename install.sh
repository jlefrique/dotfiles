#!/bin/bash

set -x
set -e

GIT=$(which git)
REPOSITORY="git://github.com/jlefrique/dotfiles.git"

BASE_PATH="$HOME"
DOTFILES="$BASE_PATH/dotfiles"
BIN="$BASE_PATH/bin"

FILES="\
Xresources
dmenurc
gitconfig
mailcap
muttrc
tmux.conf
vimrc
xscreensaver
xsession
zshrc"

FOLDERS="\
config
mutt
xmonad
vim
xrdb
zsh"

[ -f "$GIT" ] || $(echo "Please install git." && exit 1)

# Clone or update the repository
if [ -d "$DOTFILES" ]; then
    pushd "$DOTFILES" > /dev/null
    $GIT pull --recurse-submodules origin master
    popd > /dev/null
else
    $GIT clone --recursive "$REPOSITORY" "$DOTFILES"
fi

$DOTFILES/bin/check_bin.sh

# Create symlinks for files
for file in $FILES; do
    [ -h "$BASE_PATH/.$file" ] && rm "$BASE_PATH/.$file"
    ln -s "$DOTFILES/$file" "$BASE_PATH/.$file"
done

# Create symlinks for the files in the different folders
for folder in $FOLDERS; do
    # Create the folder if it doesn't exist
    [ -d "$BASE_PATH/.$folder" ] || mkdir "$BASE_PATH/.$folder"

    for file in `ls "$DOTFILES/$folder"`; do
        [ -h "$BASE_PATH/.$folder/$file" ] && rm "$BASE_PATH/.$folder/$file"
        ln -s "$DOTFILES/$folder/$file" "$BASE_PATH/.$folder/$file"
    done
done

# Create symlinks for binaries
[ -d "$BIN" ] || mkdir "$BIN"
for file in `ls "$DOTFILES/bin"`; do
    [ -h "$BIN/$file" ] && rm "$BIN/$file"
    ln -s "$DOTFILES/bin/$file" "$BIN/$file"
done

exit 0
