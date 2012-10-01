#!/bin/bash

# Load resources
xrdb -merge .Xdefaults

# Set up an icon tray
trayer --edge top --align right --SetDockType true --expand true \
--widthtype percent --width 10 --transparent true --alpha 0 --tint 0x000000 \
--heighttype pixel --height 18 &

# Set the background color
#xsetroot -solid midnightblue

~/bin/set_keyboard.sh

# Per-machin config, if any
if [ -f ~/bin/init-machine.sh ] ; then
  source ~/bin/init-machine.sh
fi

# Fire up apps
pidgin &

xscreensaver -no-splash &

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

if [ -x /usr/bin/xfce4-power-manager ] ; then
   sleep 3
   xfce4-power-manager &
fi

