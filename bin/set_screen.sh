#!/bin/bash

case "$(hostname)" in

    walnut)
        xrandr --output LVDS --primary --mode 1400x1050 --rotate normal
        if [[ "$1" == "tv" ]]; then
            xrandr --output VGA-0 --mode 800x600 --left-of LVDS
        fi
    ;;

    aspen)
        xrandr --output DVI-0 --primary --mode 1680x1050 --rotate normal
        xrandr --output VGA-0 --mode 1920x1080 --right-of DVI-0 --rotate normal
    ;;

    *) echo "No screen configuration found." ;;

esac
