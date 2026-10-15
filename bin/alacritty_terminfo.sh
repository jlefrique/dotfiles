#!/bin/sh

# Installs alacritty's upstream terminfo entries in ~/.terminfo. Distribution
# packages (ncurses-term) ship an older entry that lacks newer capabilities.
# Source: https://github.com/alacritty/alacritty/blob/master/INSTALL.md

set -e

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

curl -sfL -o "$tmp_dir/alacritty.info" \
    https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info
tic -xe alacritty,alacritty-direct "$tmp_dir/alacritty.info"
infocmp alacritty-direct > /dev/null && echo "alacritty terminfo installed"
