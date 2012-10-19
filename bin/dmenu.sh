#!/bin/sh

if [ -f "${HOME}/.dmenurc" ]; then
    . "${HOME}/.dmenurc"
else
    DMENU='dmenu -i'
fi

$DMENU ${1+"$@"}
