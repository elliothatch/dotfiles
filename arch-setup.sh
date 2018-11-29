#!/bin/sh

# useful initial packages
pacman -S connman dialog git wpa_supplicant zsh

# user setup
useradd --create-home ellioth
passwd ellioth
chsh ellioth -s /bin/zsh

visudo # add this line: ellioth ALL=(ALL) ALL

systemctl enable connman
systemctl start connman

# install packages
pacman -S $(cat ./pacman-packages.txt | sed '/^#/ d' | tr '\n' ' ')

# AUR package manager
mkdir $HOME/build
cd $HOME/build
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay --no-prompt -S $(cat ./aur-packages.txt | sed '/^#/ d' | tr '\n' ' ')

systemctl enable gdm

# enable firewall
systemctl enable nftables


# set up yubikey https://support.yubico.com/support/solutions/articles/15000006449-using-your-u2f-yubikey-with-linux
curl https://raw.githubusercontent.com/Yubico/libu2f-host/master/70-u2f.rules > /etc/udev/rules.d/70-u2f.rules
