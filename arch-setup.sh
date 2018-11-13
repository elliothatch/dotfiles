#!/bin/sh

# AUR package manager
mkdir $HOME/build
cd $HOME/build
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# network
pacman -S wpa_supplicant

# bluetooth
# pacman -S bluez

# vpn
# pacman -S openvpn

pacman -S connman
# network gui
yay -S cmst
# yay -S kdesu netctl-gui

pacman -S openssh

# GUI
## window manager
yay -S wlroots-git sway-git

## status bar
yay -S i3blocks-git

## notifications
yay -S mako-git

yay -S wl-clipboard-git

# fonts
pacman -S ttf-dejavu noto-fonts noto-fonts-emoji ttf-font-awesome
# yay -S nerd-fonts-dejavu-complete # icons are too small
fc-cache -f -v

# system monitors
pacman -S sysstat

# audio
pacman -S alsa-utils pavucontrol

# laptop
## power
pacman -S acpi
# pacman -S acpid
# systemctl enable acpid.service

## backlight
pacman -S light

# network
pacman -S connman

# user programs
pacman -S neovim fzf the_silver_searcher

# file manager
yay -S ranger-git

# image viewer
pacman -S imv

yay -S slack-desktop

# set up yubikey https://support.yubico.com/support/solutions/articles/15000006449-using-your-u2f-yubikey-with-linux