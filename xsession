#!/bin/bash

# Load resources
xrdb -merge ~/.Xresources

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Change measuring units, paper size and first day of week
export LC_MEASUREMENT="en_GB.UTF-8"
export LC_PAPER="en_GB.UTF-8"
export LC_TIME="en_GB.UTF-8"

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
    eval $(cat ~/.fehbg)
else
    xsetroot -solid black
fi

if [ -x "`which xscreensaver 2>/dev/null`" ] ; then
    xscreensaver -no-splash &
fi

if [ -x "`which nm-applet 2>/dev/null`" ] ; then
    nm-applet --sm-disable &
fi

if [ -x "`which xfce4-power-manager 2>/dev/null`" ] ; then
    sleep 3
    xfce4-power-manager &
fi

# Start mpd daemon if no other user instance exists
if [ ! -s ~/.mpd/pid -a -x "`which mpd 2>/dev/null`" ] ; then
    mpd
fi

# Fire up apps
for application in pidgin redshift ; do
    [ -x "`which  $application 2>/dev/null`" ] && $application &
done

# Wait for window manager to exit
wait $wmpid
