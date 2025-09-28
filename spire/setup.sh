#!/bin/sh
trap "exit" INT
# setup.sh is meant to be run once you have completed Arch Linux installation and are booted into the actual OS on disk for the first time as the root user
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

$DIR/../core/setup.sh

# intel
sudo pacman -S intel-ucode
sudo pacman -S mesa

sudo $DIR/../install-pacman.sh $DIR/pacman-packages.txt

# change lid and power button actions
sudo cp -i $DIR/etc/systemd/logind.conf /etc/systemd/logind.conf

# give user permissions to change backlight brightness
sudo gpasswd -a ellioth video

$DIR/../wayland/setup.sh
ln -svirn $DIR/.config/sway/output $HOME/.config/sway/output

$DIR/../icebox-client/setup.sh
$DIR/../applications/setup.sh

