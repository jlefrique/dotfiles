#!/bin/bash

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

    *) echo "No screen configuration found." ;;

esac
