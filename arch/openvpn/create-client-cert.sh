#!/bin/bash
# usage: create-client-cert [client-user]
cd /etc/easy-rsa
easyrsa gen-req "$1" nopass
easyrsa sign-req client "$1"


# on client machine
# cp server.com:/etc/easy-rsa/pki/ca.crt /etc/openvpn/client/ca.crt 
# cp server.com:/etc/openvpn/server/ta.key /etc/openvpn/client/ta.key
# cp server.com:/etc/easy-rsa/pki/private/"$1".key /etc/openvpn/client/client.key 
# cp server.com:/etc/easy-rsa/pki/issued/"$1".crt /etc/openvpn/client/client.crt 

# clean up
# rm /etc/easy-rsa/pki/reqs/"$1".req
# rm /etc/easy-rsa/pki/private/"$1".key
