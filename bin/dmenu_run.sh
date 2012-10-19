#!/bin/sh

DMENU='dmenu.sh'

exe=`dmenu_path | $DMENU ${1+"$@"}` && exec $exe
