#!/bin/sh
# gives the user permissions to directly read and write the syncthing shared directory (without using syncthing)
USERNAME="$1"
SHAREDDIRNAME="$2"
if [ -z "$1" ] || [ -z "$2" ]; then
	echo "usage: add-syncdir-shared <USERNAME> <SHAREDDIRNAME>"
	exit 1
fi

sudo setfacl -R -m "u:syncthing:rwX" /srv/samba/syncthing/$SHAREDDIRNAME
sudo setfacl -R -m "u:$USERNAME:rwX" /srv/samba/syncthing/$SHAREDDIRNAME

sudo setfacl -R -d -m "u:syncthing:rwX" /srv/samba/syncthing/$SHAREDDIRNAME
sudo setfacl -R -d -m "u:$USERNAME:rwX" /srv/samba/syncthing/$SHAREDDIRNAME

# now you can add SHAREDDIRNAME as a share in smb.conf. don't forget to give permissions to the user
