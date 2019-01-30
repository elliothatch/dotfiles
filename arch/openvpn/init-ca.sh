#!/bin/bash
# usage: init-ca [servername]

cd /etc/easy-rsa
export EASYRSA=$(pwd)

easyrsa init-pki
easyrsa build-ca

cp /etc/easy-rsa/pki/ca.crt /etc/openvpn/server/
chown root:root /etc/openvpn/server/ca.crt

# generate server cert
easrsa gen-req "$1" nopass
cp /etc/easy-rsa/pki/private/"$1".key /etc/openvpn/server/

openssl dhparam -out /etc/openvpn/server/dh.pem 2048

openvpn --genkey --secret /etc/openvpn/server/ta.key

easyrsa sign-req server "$1"

rm /etc/easy-rsa/pki/reqs/"$1".req

# install server cert
cp /etc/easy-rsa/pki/issued/"$1".crt /etc/openvpn/server/
chown root:root /etc/openvpn/server/"$1".crt
