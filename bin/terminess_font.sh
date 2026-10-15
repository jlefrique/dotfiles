#!/bin/sh

# Installs the Terminess Nerd Font in ~/.local/share/fonts. Terminess is a
# vector version of Terminus patched with the Nerd Font icons used by nvim
# plugins (e.g. octo.nvim). The regular variant draws icons at full size,
# overflowing into the next cell; the Mono variant shrinks them to one cell.
# Source: https://github.com/ryanoasis/nerd-fonts

set -e

font_dir="$HOME/.local/share/fonts/TerminessNerdFont"
tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

curl -sfL -o "$tmp_dir/Terminus.tar.xz" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Terminus.tar.xz
mkdir -p "$font_dir"
tar -xf "$tmp_dir/Terminus.tar.xz" -C "$font_dir" --wildcards 'TerminessNerdFont-*' 'TerminessNerdFontMono-*' LICENSE.txt
fc-cache -f "$font_dir"
fc-list | grep -q "TerminessNerdFont-" && echo "Terminess Nerd Font installed"
