#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sudo $DIR/../install-pacman.sh $DIR/pacman-packages.txt
$DIR/../install-yay.sh $DIR/aur-packages.txt

sudo mkdir -p /mnt/icebox/fresh4less
echo '//icebox.fresh4less.org/fresh4less /mnt/icebox/fresh4less cifs rw,credentials=/etc/samba/credentials/icebox,iocharset=utf8,uid=ellioth,gid=ellioth,file_mode=0770,dir_mode=0770,x-systemd.automount 0 0' | sudo tee -a /etc/fstab

sudo mkdir -p /mnt/icebox/ellioth
echo '//icebox.fresh4less.org/ellioth /mnt/icebox/ellioth cifs rw,credentials=/etc/samba/credentials/icebox,iocharset=utf8,uid=ellioth,gid=ellioth,file_mode=0770,dir_mode=0770,x-systemd.automount 0 0' | sudo tee -a /etc/fstab

sudo mkdir -p /mnt/icebox/public
echo '//icebox.fresh4less.org/public /mnt/icebox/public cifs rw,credentials=/etc/samba/credentials/icebox,iocharset=utf8,uid=ellioth,gid=ellioth,file_mode=0770,dir_mode=0770,x-systemd.automount 0 0' | sudo tee -a /etc/fstab

sudo mkdir -p /mnt/icebox/samnelliot
echo '//icebox.fresh4less.org/samnelliot /mnt/icebox/samnelliot cifs rw,credentials=/etc/samba/credentials/icebox,iocharset=utf8,uid=ellioth,gid=ellioth,file_mode=0770,dir_mode=0770,x-systemd.automount 0 0' | sudo tee -a /etc/fstab

sudo mkdir -p /etc/samba/credentials
echo -e 'username=ellioth\npassword=' | sudo tee /etc/samba/credentials/icebox
sudo chmod 600 /etc/samba/credentials/icebox

systemctl --user enable syncthing.service --now

mkdir $HOME/sync

rmdir Documents && ln -s $HOME/sync/icebox-ellioth/documents Documents
rmdir Public && ln -s $HOME/sync/icebox-public Public

echo ''
echo 'Manual setup required:'
echo 'Add Samba credentials'
echo '   /etc/samba/credentials/icebox'
