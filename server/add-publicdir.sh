#!/bin/sh
USERNAME="$1"
if [ -z "$1" ]; then
	echo "usage: add-publicdir <USERNAME>"
	exit 1
fi

setfacl -m "u:http:r-x" /srv/samba/$USERNAME

mkdir /srv/samba/$USERNAME/public
chown $USERNAME:$USERNAME /srv/samba/$USERNAME/public
# chown root:staff /srv/samba/$USERNAME/public
chmod g+s /srv/samba/$USERNAME/public
chmod -R g+rw /srv/samba/$USERNAME/public

# ensure both user and http always have access
setfacl -R -m "u:http:rwX" /srv/samba/$USERNAME/public
setfacl -R -m "u:$USERNAME:rwX" /srv/samba/$USERNAME/public
# setfacl -R -m "g:staff:rwX" /srv/samba/$USERNAME/public

setfacl -R -d -m "u:http:rwX" /srv/samba/$USERNAME/public
setfacl -R -d -m "u:$USERNAME:rwX" /srv/samba/$USERNAME/public
# setfacl -R -d -m "g:staff:rwX" /srv/samba/$USERNAME/public

mkdir /srv/samba/$USERNAME/public/unlisted
chown $USERNAME:$USERNAME /srv/samba/$USERNAME/public/unlisted
# chown root:staff /srv/samba/$USERNAME/public/unlisted
chmod g+s /srv/samba/$USERNAME/public/unlisted
chmod -R g+rw /srv/samba/$USERNAME/public/unlisted

# ensure both user and http always have access
setfacl -R -m "u:http:rwX" /srv/samba/$USERNAME/public/unlisted
setfacl -R -m "u:$USERNAME:rwX" /srv/samba/$USERNAME/public/unlisted
# setfacl -R -m "g:staff:rwX" /srv/samba/$USERNAME/public/unlisted

setfacl -R -d -m "u:http:rwX" /srv/samba/$USERNAME/public/unlisted
setfacl -R -d -m "u:$USERNAME:rwX" /srv/samba/$USERNAME/public/unlisted
# setfacl -R -d -m "g:staff:rwX" /srv/samba/$USERNAME/public/unlisted

ln -s /srv/samba/$USERNAME/public /srv/http/files/$USERNAME
chown -h http:http /srv/http/files/$USERNAME
