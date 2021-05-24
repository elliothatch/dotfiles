#!/bin/sh
USERNAME="$1"
if [ -z "$1" ]; then
	echo "usage: add-syncdir <USERNAME>"
	exit 1
fi

mkdir /srv/samba/$USERNAME/sync
chown $USERNAME:$USERNAME /srv/samba/$USERNAME/sync
chmod g+s /srv/samba/$USERNAME/sync
chmod -R g+rw /srv/samba/$USERNAME/sync

setfacl -m "u:syncthing:r-x" /srv/samba/$USERNAME

# ensure both user and syncthing always have access
setfacl -R -m "u:syncthing:rwX" /srv/samba/$USERNAME/sync
setfacl -R -m "u:$USERNAME:rwX" /srv/samba/$USERNAME/sync

setfacl -R -d -m "u:syncthing:rwX" /srv/samba/$USERNAME/sync
setfacl -R -d -m "u:$USERNAME:rwX" /srv/samba/$USERNAME/sync

# for public
#setfacl -R -m "g:staff:rwX" /srv/samba/public/sync
#setfacl -R -d -m "g:staff:rwX" /srv/samba/public/sync
