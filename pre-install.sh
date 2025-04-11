#!/bin/bash

# for dual boot, first install windows. disable secure boot.
# for UEFI, the boot partition must be GPT mode
#If you are installing Windows from scratch, you can dictate the size of the EFI system partition during installation:
#     Select your installation target and make sure it has no partitions.
#     Click New and then the Apply buttons. The Windows installer will then generate the expected partitions (allocating nearly everything to its primary partition) and just 100MB to the EFI.
#     Use the UI to delete the System, MSR, and Primary partitions. Leave the Recovery partition (if present) alone.
#     Press Shift+F10 to open the Command Prompt.
#     Type `diskpart.exe` and press Enter to open the disk partitioning tool.
#     Type `list disk` and press Enter to list your disks. Find the one you intend to modify and note its disk number.
#     Type `select disk disk_number` with the disk number to modify.
#     Type `create partition efi size=size` with the desired size of the ESP in Mebibytes (MiB), and press Enter. (recommended size: 1024)
#     Type `format quick fs=fat32 label=System` and press Enter to format the ESP
#     Type `exit` and press Enter to exit the disk partitioning tool and exit followed by Enter again.
# 
# Once Windows is installed, you can resize the primary partition down within Windows and then reboot and go about your usual Arch install, filling the space you just created. 
# recommended partitioning: 
# 1TB SSD - 300GB Windows
# 1TB HDD - 700GB Windows

# disable fast startup and hibernation on windows console:
# powercfg /H off
# it is also recommended to configure windows with UTC time. run in an admin console:
# reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_DWORD /f
# fully shutdown (not reset or restart) before installing linux


# boot the Arch Linux installation medium

# check locale. should list Locale as LANG=en_US.UTF-8
localectl
# if it's not, you can check the available layouts with `localectl list-keymaps`, and then load your chosen one with e.g. `loadkeys en_US`

# optional set HiDPI font
setfont ter-132b

# verify boot mode
# should be 32 or 64 for UEFI. if the file/directory doesn't exist, partition with BIOS (MBR) table
cat /sys/firmware/efi/fw_platform_size

# check network connection
ip link

# wifi setup. 
iwctl
# device list
# replace wlan0 if it is not your adapter name
## you may not need the following 2 commands
# device wlan0 set-property Powered on
# adapter wlan0 set-property Powered on
# station wlan0 scan
# station wlan0 get-networks
# station wlan0 connect _SSID_

# test internet
ping archlinux.org

# check system clock
timedatectl

# partition disks
fdisk -l

# for arch-only installation, replace the partition table with GPT and create a 1GiB boot partition
fdisk /dev/sda
g
n
# primary, partiion 1, default first sector, for last sector use '+1G'

# for old systems, set up with BIOS/DOS (MBR) instead of GPT (UEFI) by using 'o' instead of 'g'. you do not need to create a boot partition, but make a 4GiB swap partition (ID 82) at the beginning of the disk instead

# for dual boot we are assuming we already partitioned the disks during windows setup, leaving empty space for the linux partitions we will now set up
fdisk /dev/sda
n
# use linux file system
# finish partitioning
fdisk /dev/sdb
n

# format the partitions, where R is the root partition number and D is the data parition (on HDD)
mkfs.ext4 /dev/sdaD
mkfs.ext4 /dev/sdbR

# mount the file systems
# where sdbU is the UEFI boot partition
mount --mkdir /dev/sdbR /mnt
mount --mkdir=0700 /dev/sdbU /mnt/boot -o fmask=0077,dmask=0077
mount --mkdir /dev/sdaD /mnt/data

# update installer keyring
pacman -Sy archlinux-keyring
# install packages
pacstrap -K /mnt base linux linux-firmware base-devel less iwd dialog git neovim wpa_supplicant zsh

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

# set the timezone
ln -sf /usr/share/zoneinfo/US/Mountain /etc/localtime

hwclock --systohc

# edit /etc/locale.gen to uncomment en_US.UTF-8 UTF-8
locale-gen

# create /etc/locale.conf with:
# LANG=en_US.UTF-8

# create /etc/hostname
# yourhostname

# network configuration
# set up networks with systemd-networkd
mkdir -p /etc/systemd/network
# copy files
# ./core/etc/systemd/network/20-ethernet.network
# ./core/etc/systemd/network/25-wlan.network
# ./core/etc/systemd/network/30-wwan.networt
systemctl enable systemd-networkd
systemctl enable systemd-resolved

# wireless setup
# check that your network interfaces show up
ip link

# if your wireless interface does not appear, but worked before pacstrap, determine drivers needed
# exit chroot, then run:
lspci -k
# then reenter chroot
# complete network configuration...

# iwd
# /etc/iwd/main.conf
# [General]
# EnableNetworkConfiguration=true
#
# [Network]
# NameResolvingService=systemd

#ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
systemctl enable iwd

# set root password
passwd

# install UEFI bootloader (systemd-boot). see below for BIOS setup
# check that UEFI variables are accessible
efivar --list
# or
ls /sys/firmware/efi/efivars

bootctl install

# bootloader configuration
# /boot/loader/loader.conf
# default  arch.conf
# timeout  3
# console-mode max
## console-mode auto
## console-mode keep
# editor   no

# add arch loader
# use UUID of the linux root filesystem
ls -l /dev/disk/by-uuid
# /boot/loader/entries/arch.conf
# title   Arch Linux
# linux   /vmlinuz-linux
## initrd  /intel-ucode.img
# initrd  /amd-ucode.img
# initrd  /initramfs-linux.img
# options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw

# tip: in vim, insert the UUID into the buffer
# :r!ls -l /dev/disk/by-uuid

cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-fallback.conf
# /boot/loader/entries/arch-fallback.conf
# title   Arch Linux (fallback initramfs)
# linux   /vmlinuz-linux
## initrd  /intel-ucode.img
# initrd  /amd-ucode.img
# initrd  /initramfs-linux-fallback.img
# options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw

# if systemd-boot doesn't run or show up in the BIOS boot menu, bootctl may have failed to add the boot entry
# view the boot entries
efibootmgr --unicode
# if there is no "Linux Boot Manager" entry, you can add it manually. it will be put first in the boot order
efibootmgr --create --disk /dev/nvme0n1 --part 1 --loader '\EFI\systemd\systemd-bootx64.efi' --label 'Linux Boot Manager' --unicode

# potentially useful output for debugging boot issues
blkid


# LEGACY: if you need to use BIOS instead of UEFI
# systemd-boot does not support BIOS, instead, set up GRUB (MBR)
#pacman -S grub
#grub-install --target=i386-pc /dev/sda
#grub-mkconfig -o /boot/grub/grub.cfg

# install microcode
#pacman -S intel-ucode
pacman -S amd-ucode

# set system-wide environment variables
# /etc/profile.d/editor.sh
# #!/bin/sh
# export EDITOR=nvim
# export VISUAL=nvim

# reboot
exit
umount -R /mnt
reboot

# log into root account and start setup
# if the wifi interface is missing, but worked in the install media, you might need to install the `broadcom-wl` package

# create user
useradd --create-home ellioth
passwd ellioth
chsh ellioth -s /bin/zsh

# setup hosts
# Add "ellioth" to sudoers
visudo
# add line (after root ALL=(ALL:ALL) ALL)
ellioth ALL=(ALL:ALL) ALL

# modify line (keeps your default editor while in sudo)
# Defaults env_keep!visudo += "SUDO_EDITOR EDITOR VISUAL"
Defaults env_keep += "SUDO_EDITOR EDITOR VISUAL"

# log into the user account and clone this repo to run install scripts
git clone https://github.com/elliothatch/dotfiles.git

cd dotfiles
sudo ./setup.sh
./user-setup.sh
