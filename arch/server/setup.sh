#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

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

# create backup volume
sudo mount -t btrfs /dev/sda1 /mnt/btrfs
sudo btrfs subvolume create /mnt/btrfs/backup
sudo umount /mnt/btrfs

sudo ln -svirn backup-btrfs.py /usr/bin/backup-btrfs
sudo cp ./etc/systemd/system/backup-btrfs.service /etc/systemd/system
sudo cp ./etc/systemd/system/backup-btrfs.timer /etc/systemd/system
