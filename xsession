#!/bin/bash

# Load resources
xrdb -merge .Xresources

# Set up an icon tray
trayer --edge top --align right --SetDockType true --expand true \
--widthtype percent --width 10 --transparent true --alpha 0 --tint 0x000000 \
--heighttype pixel --height 18 &

# Set the background color
#xsetroot -solid midnightblue

~/bin/set_keyboard.sh
~/bin/dbt-init.sh

# Fire up apps
pidgin &

xscreensaver -no-splash &

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

if [ -x /usr/bin/gnome-power-manager ] ; then
   sleep 3
   gnome-power-manager &
fi

