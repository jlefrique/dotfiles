#!/bin/sh

# Sets the keyboard layout and repetition rate for the X session.
#
# us is active by default, for keyboards typing Dvorak in hardware (e.g. a
# TypeMatrix, or an XD75 with QMK). Pressing both Shift keys switches to
# Dvorak in software, e.g. for a laptop's built-in keyboard, and back. A
# machine can override the settings in ~/.keyboard.local.

LAYOUT=us,us
VARIANT=,dvorak
OPTIONS=compose:ralt,caps:none,grp:shifts_toggle
# shellcheck source=/dev/null
[ -f ~/.keyboard.local ] && . ~/.keyboard.local

# The empty -option clears the options set earlier, so reruns do not add them
# again.
setxkbmap -layout "$LAYOUT" -variant "$VARIANT" -option '' -option "$OPTIONS"

# Keyboard repetition rate
xset r rate 300 50
