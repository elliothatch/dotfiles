#!/bin/sh
trap "exit" INT
# setup.sh is meant to be run once you have completed Arch Linux installation and are booted into the actual OS on disk for the first time as the root user
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

$DIR../core/setup.sh

sudo pacman -S mesa

$DIR/wayland/setup.sh
$DIR/icebox-client/setup.sh
$DIR/applications/setup.sh

sudo $DIR/../install-pacman.sh $DIR/pacman-packages.txt

ln -svirn $DIR/.config/* $HOME/.config

# don't suspend when lid closed
sudo mkdir -p /etc/systemd/logind.conf.d
sudo cp $DIR/etc/systemd/logind.conf.d/20-lid.conf /etc/systemd/logind.conf.d

mkdir -p $HOME/.config/mympd

systemctl --user edit mpd.service
systemctl --user restart mpd.service
# add lines to avoid timeout on login
# [Service]
# Type=simple
systemctl --user enable mympd.service --now

sudo cp $DIR/etc/nftables.conf /etc/nftables.conf
sudo nft flush ruleset
sudo nft -f /etc/nftables.conf

echo ''
echo 'Manual setup required:'
echo 'MyMPD'
echo '   Disable SSL - change ~/.config/mympd/config/ssl to true'
