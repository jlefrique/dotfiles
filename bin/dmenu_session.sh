#!/bin/bash
#
# A simple dmenu session script.
#
#
# The user has to be allowed to run some commands without password.
#
# $ sudo groupadd shutdown
# $ sudo useradd <username> shutdown
# $ sudo visudo
#
# Add the following lines:
#    %shutdown ALL=(root) NOPASSWD: /sbin/shutdown
#    %shutdown ALL=(root) NOPASSWD: /usr/sbin/pm-suspend 
#    %shutdown ALL=(root) NOPASSWD: /usr/sbin/pm-hibernate 

if [ -f "${HOME}/.dmenurc" ]; then
    . "${HOME}/.dmenurc"
else
    DMENU='dmenu -i'
fi

LOCK='xscreensaver-command -lock'

choice=$(echo -e "lock\nshutdown\nreboot\nsuspend\nhibernate" | $DMENU)

case "$choice" in
    lock) $LOCK & ;;
    shutdown) sudo shutdown -h now & ;;
    reboot) sudo shutdown -r now & ;;
    suspend) $LOCK && sudo pm-suspend & ;;
    hibernate) $LOCK && sudo pm-hibernate & ;;
esac
