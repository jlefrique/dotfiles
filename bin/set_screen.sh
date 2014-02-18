#!/bin/sh

case "$(hostname)" in

    walnut) \
        xrandr --output LVDS --primary --mode 1400x1050 --rotate normal ;;

    aspen) \
        xrandr --output DVI-0 --primary --mode 1680x1050 --rotate normal && \
        xrandr --output VGA-0 --mode 1920x1080 --right-of DVI-0 --rotate normal ;;

    *) echo "No configuration found." ;;

esac
