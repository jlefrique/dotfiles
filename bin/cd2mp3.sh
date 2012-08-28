#!/bin/sh

# Extract the entire disc, putting each track in a separate file.
cdparanoia -vsQ && cdparanoia -B
[ $? -ne 0 ] && exit 1

# Convert wav files to mp3.
for t in `ls *.wav`
do
  lame -b 192 $t
done

exit 0
