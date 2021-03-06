#!/bin/bash

usage() {
cat << EOF
usage: $0 options

Display quotes

OPTIONS:
    -s      Specify a separator (default is a new line)
    -q      Quote. If not given, print the default quotes
EOF
}


# Default separator
SEPARATOR="\n"

get_quote() {
    echo $(timeout 5s curl -s "https://api.iextrading.com/1.0/stock/$1/price" || echo 'N/A')
}

get_currency() {
    get_quote "$1=X"
}


while getopts “hs:q:” OPTION
do
    case $OPTION in
        h)
            usage
            exit 0
            ;;
        s)
            SEPARATOR="$OPTARG"
            ;;
        q)
            QUOTE="$OPTARG"
            printf "$QUOTE: $(get_quote "$QUOTE")"
            exit 0
            ;;
        ?)
            usage
            exit 1
            ;;
        esac
done

# Default quotes
printf "MRVL: $(get_quote "MRVL")${SEPARATOR}EUR/CHF: $(get_currency "EURCHF")"

exit 0
