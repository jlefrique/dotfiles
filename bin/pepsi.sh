#!/bin/sh

COUNT=$(curl www.qoqa.ch | grep -c "soldout")

if [ $COUNT -ne 0 ] ; then
    echo "Sold out."
else
    echo "Available."
    notify-send "Available."
fi
