#!/bin/bash

usage() {
cat << EOF
usage: $0 options

Display weather

OPTIONS:
    -s      Weather station ID
EOF
}


BASE_URL="http://tgftp.nws.noaa.gov/data/observations/metar/decoded/"
STATION="LSGG"  # Default station: Geneve-Cointrin, Switzerland


while getopts “hs:” OPTION
do
    case $OPTION in
        h)
            usage
            exit 0
            ;;
        s)
            STATION="$OPTARG"
            ;;
        ?)
            usage
            exit 1
            ;;
        esac
done


WEATHER=$(curl -s "${BASE_URL}${STATION}.TXT")

STATION_NAME=$(echo "${WEATHER}" | head -n 1 | cut -d',' -f1)
TEMPERATURE=$(echo "${WEATHER}" | grep "Temperature" | sed 's/.*(\(.*\) C)/\1/')

printf "${STATION_NAME}: ${TEMPERATURE}C"

exit 0
