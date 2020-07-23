#!/bin/bash
# usage: username groupname
useradd "$1"
passwd "$1"
smbpasswd -a "$1"

gpasswd -a "$1" "$2"
mkdir /srv/samba/"$1"
chown "$1":"$1" /srv/samba/"$1"
chmod 750 /srv/samba/"$1"

