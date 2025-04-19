#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# swapfile
sudo dd if=/dev/zero of=/swapfile bs=1M count=2k status=progress
sudo chmod 0600 /swapfile
sudo mkswap -U clear /swapfile
sudo swapon /swapfile
echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab

# DNS
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# pick fastest package mirrors
sudo pacman -S reflector rsync
sudo reflector --verbose --latest 25 --sort rate --country US, --download-timeout 60 --save /etc/pacman.d/mirrorlist

# install core packages
pacman -Syu
sudo $DIR/../install-pacman.sh $DIR/pacman-packages.txt

# aur setup
mkdir $HOME/build
git clone https://aur.archlinux.org/yay.git $HOME/build/yay
(
	cd $HOME/build/yay
	makepkg -si
)

$DIR/../install-yay.sh $DIR/aur-packages.txt

sudo mandb -c

# profile.d
sudo cp $DIR/etc/profile.d/* /etc/profile.d/

# systemd environment

# fonts
sudo cp $DIR/etc/fonts/local.conf /etc/fonts/local.conf

# speech-dispatcher
sudo cp $DIR/etc/speech-dispatcher/speechd.conf /etc/speech-dispatcher/speechd.conf
sudo systemctl enable espeakup.service --now

# ntp
sudo systemctl enable systemd-timesyncd --now
# verify time
#sudo timedatectl show-timesync --all

# firewall
sudo systemctl enable nftables --now

# printer
sudo systemctl enable cups --now

# system neovim config
sudo cp -R $DIR/etc/xdg/nvim/colors /etc/xdg/nvim/colors
sudo cp $DIR/etc/xdg/nvim/init.vim /etc/xdg/nvim/init.vim

# nvim config
sudo npm install -g neovim

# node config
fnm install $(fnm list-remote | tail -1)

# user config
sudo gpasswd -a $USER network

mkdir -p $HOME/.zsh
mkdir -p $HOME/.config

ln -svirn $DIR/.config/* $HOME/.config
ln -svirn $DIR/dotfiles/.* $HOME

# mpd
mkdir -p $HOME/.local/share/mpd
mkdir -p $HOME/.local/share/mpd/playlists
mkdir -p $HOME/.local/state/mpd

systemctl --user enable mpd.service --now


# xdg
# make firefox default browser
xdg-settings set default-web-browser firefox.desktop

xdg-user-dirs-update
