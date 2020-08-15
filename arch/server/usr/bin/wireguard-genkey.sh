#!/bin/sh
# usage: genkey.sh username
wg genkey | tee "$1".key | wg pubkey > "$1".pub
