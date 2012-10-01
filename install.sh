#!/bin/bash

set -x
set -e

GIT=$(which git)
REPOSITORY="git://github.com/jlefrique/dotfiles.git"

BASE_PATH="$HOME"
DOTFILES="$BASE_PATH/dotfiles"
BIN="$BASE_PATH/bin"

SYMLINKS="\
vim
vimrc
tmux.conf
xmonad
mutt
muttrc
zshrc
gitconfig
xsession
Xdefaults
mailcap"

[ -f "$GIT" ] || $(echo "Please install git." && exit 1)

# Clone or update the repository
if [ -d "$DOTFILES" ]; then
  pushd "$DOTFILES" > /dev/null
  $GIT pull --recurse-submodules origin master
  popd > /dev/null
else
  $GIT clone --recursive "$REPOSITORY"  "$DOTFILES"
fi

# Create symlinks for dotfiles
for file in $SYMLINKS; do
  [ -h "$BASE_PATH/.$file" ] && rm "$BASE_PATH/.$file"
  ln -s "$DOTFILES/$file" "$BASE_PATH/.$file"
done

# Create symlinks for binaries
[ -d "$BIN" ] || mkdir "$BIN"
for file in `ls "$DOTFILES/bin"`; do
  [ -h "$BIN/$file" ] && rm "$BIN/$file"
  ln -s "$DOTFILES/bin/$file" "$BIN/$file"
done

# Set zsh as default shell
chsh -s /bin/zsh

exit 0

