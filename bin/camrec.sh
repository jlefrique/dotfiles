#!/bin/sh

HOSTNAME=$( hostname -s )

CAMERA=/dev/video0
DURATION=1800
FPS=25
RESOLUTION=640x480


if [ "$HOSTNAME" = "armadeus" ]
then
    sleep 5
    OUTPUT_PATH=/mnt/usbdisk/videos
    mount -t ext3 /dev/sda1 /mnt/usbdisk

    modprobe gspca_main
    modprobe gspca_zc3xx
    sleep 5

else
    OUTPUT_PATH=/tmp
fi

while true
do
    if [ -e $CAMERA ]
    then
        OUTPUT="$OUTPUT_PATH/$( date +'%Y-%m-%d-%H%M%S' )-$( ls -1 | wc -l ).avi"
        ffmpeg -f video4linux2 -t $DURATION -r $FPS -s $RESOLUTION -i $CAMERA $OUTPUT > /dev/null 2>&1
    fi
    sleep 3
done
