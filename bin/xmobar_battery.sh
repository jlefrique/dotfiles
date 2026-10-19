#!/bin/sh

# Prints a Nerd Font battery icon for the charge level and AC state, then the
# charge percentage padded to 3 digits, for xmobar. Prints nothing without a
# battery.

bat=/sys/class/power_supply/BAT0
ac=/sys/class/power_supply/AC/online
[ -r "$bat/capacity" ] || exit 0
level=$(cat "$bat/capacity")

if [ "$(cat "$ac" 2> /dev/null)" = 1 ]; then
    # On AC: charging until full, then a plug.
    if [ "$level" -lt 100 ]; then icon="󰂄"; else icon="󰚥"; fi
else
    # Discharging: one icon per 10%, from empty to full.
    set -- 󰂎 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹
    shift $(( (level + 5) / 10 ))
    icon="$1"
fi

if [ "$level" -le 15 ] && [ "$(cat "$ac" 2> /dev/null)" != 1 ]; then
    printf '<fc=#ee5396>%s  %3d%%</fc>\n' "$icon" "$level"
else
    printf '%s  %3d%%\n' "$icon" "$level"
fi
