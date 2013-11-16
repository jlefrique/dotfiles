#!/bin/bash

if [[ "$(whoami)" != "root" ]]; then
    echo "Run this as root."
    exit 1
fi

cat >/etc/modprobe.d/usbserial.conf <<EOF
# MSP-EXP430F5438 board
options usbserial vendor=0x0451 product=0xF500

# Renesas board
options usbserial vendor=0x045b product=0x2014
EOF
