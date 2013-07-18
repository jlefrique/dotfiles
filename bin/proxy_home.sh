#!/bin/sh

HOST="larch.lefrique.name"
PORT=1080

echo "Listening on $PORT, forward to $HOST..."
ssh -ND $PORT $HOST
