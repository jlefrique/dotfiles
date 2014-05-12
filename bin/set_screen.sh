#!/bin/bash

case "$(hostname)" in

    walnut)
        xrandr --output LVDS --primary --mode 1400x1050 --rotate normal
        if [[ "$1" == "tv" ]]; then
            xrandr --output VGA-0 --mode 800x600 --left-of LVDS
        fi
    ;;

    *) echo "No screen configuration found." ;;

esac
