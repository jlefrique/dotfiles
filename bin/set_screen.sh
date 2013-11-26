#!/bin/sh

case "$(hostname)" in

    aspen) \
        xrandr --output "DFP1" --primary --mode 1680x1050 --rotate normal && \
        xrandr --output "CRT1" --mode 1920x1080 --right-of "DFP1" --rotate normal ;;

    *) echo "No configuration found." ;;

esac
