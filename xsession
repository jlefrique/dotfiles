#!/bin/bash

# Load resources
xrdb -merge ~/.Xresources

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Set up an icon tray
trayer --edge top --align right --SetDockType true --expand true \
--widthtype percent --width 10 --transparent true --alpha 0 --tint 0x000000 \
--heighttype pixel --height 18 &

# Set the background
if [ -f ~/.fehbg ] ; then
    eval $(cat ~/.fehbg)
else
    xsetroot -solid black
fi

# Remove beeps
xset b off

# Configure keyboard
[ -f ~/bin/set_keyboard.sh ] && ~/bin/set_keyboard.sh

# Per-machine config, if any
[ -f ~/bin/init-machine.sh ] && ~/bin/init-machine.sh

# Window manager
xmonad & wmpid=$!

if [ -x "`which unclutter 2>/dev/null`" ] ; then
    unclutter -idle 10 -noevents &
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

# Fire up apps
for application in pidgin redshift ; do
    [ -x "`which  $application 2>/dev/null`" ] && $application &
done

# Wait for window manager to exit
wait $wmpid
