#!/bin/bash

xrandr --auto

case "$(hostname)" in

    walnut)

        # Laptop screen
        WALNUT_INT=LVDS
        WALNUT_INT_MODE=1400x1050

        # External screen
        WALNUT_EXT=VGA-0
        WALNUT_EXT_MODE=1920x1200

        if [[ $(xrandr | grep -c "$WALNUT_EXT connected") -eq 0 ]]
        then
            xrandr --output $WALNUT_INT --mode $WALNUT_INT_MODE --rotate normal --primary
        else
            echo "External monitor connected."
            xrandr --output $WALNUT_EXT --mode $WALNUT_EXT_MODE --rotate normal --primary
            xrandr --output $WALNUT_INT --mode $WALNUT_INT_MODE --rotate normal --right-of $WALNUT_EXT
        fi
    ;;

    hickory)

        # Laptop screen
        INT=eDP-1
        INT_MODE=1920x1080

        # External screen
        EXT=DP-2-3
        EXT_MODE=1920x1200

        if [[ $(xrandr | grep -c "$EXT connected") -eq 0 ]]
        then
            xrandr --output $INT --mode $INT_MODE --rotate normal --primary
        else
            echo "External monitor connected."
            xrandr --output $EXT --mode $EXT_MODE --rotate normal --primary
            xrandr --output $INT --mode $INT_MODE --rotate normal --right-of $EXT
            # xrandr --output $INT --off
        fi
    ;;

    boxelder)

        RESOLUTION=1920x1080

        xrandr --output HDMI-0 --mode $RESOLUTION --rotate normal --primary
        xrandr --output VGA-0 --mode $RESOLUTION --rotate normal --right-of HDMI-0
    ;;

    *) echo "No screen configuration found." ;;

esac
