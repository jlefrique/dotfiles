#!/system/bin/sh

# Add markups in Android logcat


COUNTER=1

while read line; do
    LINE="Markup #${COUNTER} -- ${line}"
    echo ${LINE}
    log -t ${LINE}
    let COUNTER=COUNTER+1
done
