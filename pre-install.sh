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

# optional set HiDPI font
setfont ter-132b

# verify boot mode
# should be 32 or 64 for UEFI
cat /sys/firmware/efi/fw_platform_size

# check network connection
ip link
ping archlinux.org

# check system clock
timedatectl

# partition disks
fdisk -l

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
mount /dev/sdbR /mnt
mount /dev/sdbU /mnt/boot
mount /dev/sdaD /mnt/data

# install packages
pacstrap -K /mnt base linux linux-firmware base-devel connman dialog git neovim wpa_supplicant zsh

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

# complete network configuration...

# set root password
passwd

# install bootloader (systemd-boot)
# check that UEFI variables are accessible
efivar --list
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
# initrd  /intel-ucode.img
# initrd  /initramfs-linux.img
# options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw

# esp/loader/entries/arch-fallback.conf
# title   Arch Linux (fallback initramfs)
# linux   /vmlinuz-linux
# initrd  /intel-ucode.img
# initrd  /initramfs-linux-fallback.img
# options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw

# install microcode
pacman -S intel-ucode

# reboot
exit
umount -R /mnt
reboot
