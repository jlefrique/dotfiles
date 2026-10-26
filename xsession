#!/bin/bash

# Load resources
xrdb -merge ~/.Xresources

# Put the user's bin directories that exist in front of PATH, in this order
user_path=
for dir in "$HOME/bin" "$HOME/.local/bin" "$HOME/.cabal/bin" "$HOME/.cargo/bin"; do
    [ -d "$dir" ] && user_path="$user_path$dir:"
done
export PATH="$user_path$PATH"

# Let services started by D-Bus or systemd open windows on this display (some
# distributions already do it before this script).
command -v dbus-update-activation-environment > /dev/null &&
    dbus-update-activation-environment --systemd DISPLAY XAUTHORITY 2> /dev/null

# Starts a program in the background if it is installed.
start() { command -v "$1" > /dev/null && "$@" & }

# Change measuring units, paper size and first day of week
export LC_MEASUREMENT="en_GB.UTF-8"
export LC_PAPER="en_GB.UTF-8"
export LC_TIME="en_GB.UTF-8"
export LANG=en_US.UTF-8

# Warn the JVM that xmonad is non-reparenting
export _JAVA_AWT_WM_NONREPARENTING=1

# Remove beeps
xset b off

# Set up an icon tray
[ -f ~/bin/tray.sh ] && ~/bin/tray.sh

# Configure keyboard
[ -f ~/bin/set_keyboard.sh ] && ~/bin/set_keyboard.sh

# Configure screen
[ -f ~/bin/set_screen.sh ] && ~/bin/set_screen.sh

# Per-machine config, if any
[ -f ~/bin/init-machine.sh ] && ~/bin/init-machine.sh

# Window manager
xmonad & wmpid=$!

# Set the background
if [ -f ~/.fehbg ] ; then
    sh ~/.fehbg
else
    xsetroot -solid black
fi

start xscreensaver -no-splash
start nm-applet --sm-disable
# Delayed, in the background so the rest of the session is not held up
(sleep 3; start xfce4-power-manager) &
start redshift

# Wait for window manager to exit
wait $wmpid
