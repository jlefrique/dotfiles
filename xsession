#!/bin/bash

# Load resources
xrdb -merge ~/.Xresources

# Set up an icon tray
trayer --edge top --align right --SetDockType true --expand true \
--widthtype percent --width 10 --transparent true --alpha 0 --tint 0x000000 \
--heighttype pixel --height 18 &

# Set the background color
#xsetroot -solid midnightblue

# Configure keyboard
[ -f ~/bin/set_keyboard.sh ] && ~/bin/set_keyboard.sh

# Per-machine config, if any
[ -f ~/bin/init-machine.sh ] && ~/bin/init-machine.sh

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
for application in pidgin ; do
    [ -x "`which  $application 2>/dev/null`" ] && $application &
done
