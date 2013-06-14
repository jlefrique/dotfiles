#!/bin/sh

# Interrupt the script with CTRL-D to write the result in the output file.

HOSTNAME="imap.gmail.com"
OUTPUT="gmail-certificate.crt"

openssl s_client -CApath /etc/ssl/certs -connect ${HOSTNAME}:imaps -showcerts \
    | perl -ne 'print if /BEGIN/../END/; print STDERR if /return/' > $OUTPUT
