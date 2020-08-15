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

sudo cp $DIR/etc/systemd/system/ddns.service /etc/systemd/system
sudo cp $DIR/etc/systemd/system/ddns.timer /etc/systemd/system
sudo systemctl start ddns.timer
sudo systemctl enable ddns.timer

# TODO: add commands for setting up RAID
# set up subvolumes
sudo mount -t btrfs /dev/sda1 /mnt/btrfs
# create samba volume
sudo btrfs subvolume create /mnt/btrfs/samba
sudo mkdir /srv/samba
sudo mount -t btrfs -o subvol=samba /dev/sda1 /srv/samba
# create backup volume
sudo btrfs subvolume create /mnt/btrfs/backup
sudo mkdir /srv/backup
sudo mount -t btrfs -o subvol=backup /dev/sda1 /srv/backup
# create data volume (not backed up, e.g. game server files)
sudo btrfs subvolume create /mnt/btrfs/data
sudo mkdir /srv/data
sudo mount -t btrfs -o subvol=data /dev/sda1 /srv/data
sudo umount /mnt/btrfs

sudo cp $DIR/etc/systemd/system/backup-btrfs.service /etc/systemd/system
sudo cp $DIR/etc/systemd/system/backup-btrfs.timer /etc/systemd/system

sudo systemctl start backup-btrfs.timer
sudo systemctl enable backup-btrfs.timer

# copy samba update script. manually add the secret slack webhook URL after copy
sudo cp $DIR/usr/bin/post-samba-updates.sh /usr/bin/post-samba-updates

sudo cp $DIR/etc/systemd/system/post-samba-updates.service /etc/systemd/system
sudo cp $DIR/etc/systemd/system/post-samba-updates.timer /etc/systemd/system

sudo systemctl start post-samba-updates.timer
sudo systemctl enable post-samba-updates.timer


# link custom scripts
$DIR/link.sh
