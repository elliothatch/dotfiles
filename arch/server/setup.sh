#!/bin/sh
# disable auto-suspend in gdm
sudo machinectl shell gdm@ /bin/bash
export GSETTINGS_BACKEND=dconf
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0

# set up dynamic dns
go get github.com/anaganisk/digitalocean-dynamic-dns-ip
mkdir ~/build
cd ~/build
git clone https://github.com/anaganisk/digitalocean-dynamic-dns-ip.git
cd digitalocean-dynamic-dns-ip
go build digitalocean-dynamic-dns-ip.go

sudo cp ./etc/systemd/system/ddns.service /etc/systemd/system
sudo cp ./etc/systemd/system/ddns.timer /etc/systemd/system
sudo systemctl start ddns.timer
sudo systemctl enable ddns.timer
