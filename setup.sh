#!/bin/sh
trap "exit" INT
# setup.sh is meant to be run once you have completed Arch Linux installation and are booted into the actual OS on disk for the first time as the root user
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# user setup
echo 'Create user "ellioth"'
useradd --create-home ellioth
passwd ellioth
chsh ellioth -s /bin/zsh

# setup swapfile
dd if=/dev/zero of=/swapfile bs=1M count=2k status=progress
chmod 0600 /swapfile
mkswap -U clear /swapfile
swapon /swapfile

# pick fastest package mirrors
pacman -S reflector rsync
reflector --verbose --latest 10 --sort rate --country US, --download-timeout 60 --save /etc/pacman.d/mirrorlist

# useful initial packages, these are now included in pre-install pacstrap
# pacman -S base-devel connman dialog git wpa_supplicant zsh

pacman -Syu

# install packages
/$DIR/install-pacman.sh $DIR/core/pacman-packages.txt 

# install other packages as appropriate (example for desktop)
$DIR/install-pacman.sh $DIR/desktop/pacman-packages.txt 
$DIR/install-pacman.sh $DIR/i3/pacman-packages.txt 
$DIR/install-pacman.sh $DIR/core/pacman-packages-extra.txt 

# additional setup
# fonts
cp $DIR/core/etc/fonts/local.conf /etc/fonts/local.conf
# old nvim config with no plugins for sudo
cp -R $DIR/core/etc/xdg/nvim/colors /etc/xdg/nvim/colors
cp $DIR/core/etc/xdg/nvim/init.vim /etc/xdg/nvim/init.vim

# graphics drivers and input
#cp $DIR/desktop/etc/X11/xorg.conf.d/20-nouveau.conf /etc/X11/xorg.conf.d/20-nouveau.conf
cp $DIR/desktop/etc/X11/xorg.conf.d/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/50-mouse-acceleration.conf

# set up yubikey https://support.yubico.com/support/solutions/articles/15000006449-using-your-u2f-yubikey-with-linux
#curl https://raw.githubusercontent.com/Yubico/libu2f-host/master/70-u2f.rules > /etc/udev/rules.d/70-u2f.rules

# ntp
# edit /etc/systemd/timesyncd.conf
#NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
#FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.fr.pool.ntp.org

# verify
timedatectl show-timesync --all

# enable services
# ntp
systemctl enable systemd-timesyncd
# login
systemctl enable gdm
# firewall
systemctl enable nftables
# printer
systemctl enable cups

# setup hosts
echo 'Manual setup required:'
echo ''
echo 'Add "ellioth" to sudoers'
echo '   visudo'
echo '      ellioth ALL=(ALL) ALL'
echo 'vim /etc/hosts'
echo '   Add icebox hosts'
echo 'vim /etc/fstab'
echo '   Enable swapfile:'
echo '      /swapfile none swap defaults 0 0'
echo '   Samba network shares:'
echo '      //icebox/fresh4less /mnt/icebox/fresh4less cifs rw,credentials=/etc/samba/credentials/icebox,iocharset=utf8,uid=ellioth,gid=ellioth,file_mode=0770,dir_mode=0770,x-systemd.automount 0 0'
echo '      //icebox/ellioth /mnt/icebox/ellioth cifs rw,credentials=/etc/samba/credentials/icebox,iocharset=utf8,uid=ellioth,gid=ellioth,file_mode=0770,dir_mode=0770,x-systemd.automount 0 0'
echo '      //icebox/public /mnt/icebox/public cifs rw,credentials=/etc/samba/credentials/icebox,iocharset=utf8,uid=ellioth,gid=ellioth,file_mode=0770,dir_mode=0770,x-systemd.automount 0 0'
echo '      //icebox/samnelliot /mnt/icebox/samnelliot cifs rw,credentials=/etc/samba/credentials/icebox,iocharset=utf8,uid=ellioth,gid=ellioth,file_mode=0770,dir_mode=0770,x-systemd.automount 0 0'
echo '/etc/samba/credentials/icebox'
echo '   Add Samba credentials:'
echo '      username=ellioth'
echo '      password='
echo 'Set up /etc/nftables'
echo '   nft flush ruleset'
echo '   nft -f /etc/nftables'

