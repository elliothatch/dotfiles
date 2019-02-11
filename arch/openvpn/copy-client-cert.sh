#!/bin/bash
# usage: copy-client-cert [client-user]
TARGETDIR=/srv/samba/ellioth/"$1"
mkdir -p $TARGETDIR
cp /etc/easy-rsa/pki/ca.crt $TARGETDIR/ca.crt 
cp /etc/openvpn/server/ta.key $TARGETDIR/ta.key
cp /etc/easy-rsa/pki/private/"$1".key $TARGETDIR/client.key 
cp /etc/easy-rsa/pki/issued/"$1".crt  $TARGETDIR/client.crt 
