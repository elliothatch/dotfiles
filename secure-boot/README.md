# Secure boot with shim, systemd-boot, and Windows dual boot

This guide is assuming you are transitioning from a working systemd-boot setup with secure boot disabled.

## Setup

Install shim into the EFI boot partition.

```bash
yay -S shim-signed
```

Create a directory to put shim and the bootloader into. Shim will execute `grubx64.efi` from the same directory as shim on boot. Copy the existing bootloader there and install shim EFI binaries.

Note that we're using `system/systemd-bootx64.efi`, but this should be identical to the `Boot/bootx64.efi` when installing with `bootctl`.

```bash
sudo mkdir /boot/EFI/shim
sudo cp /boot/EFI/systemd/systemd-bootx64.efi /boot/EFI/shim/grubx64.efi

sudo cp /usr/share/shim-signed/shimx64.efi /boot/EFI/shim/
sudo cp /usr/share/shim-signed/mmx64.efi /boot/EFI/shim/
```

Add an EFI boot entry for shim. This will become the default.
```bash
sudo efibootmgr --unicode --disk /dev/nvme0n1 --part 1 --create --label "Shim" --loader /EFI/shim/shimx64.efi
```

Set up MOK (Machine Owner Key) to sign binaries to launch with Shim. Here we are creating the keys with 100 year expiry and no password, so it is not particularly secure.

```bash
sudo pacman -S sbsigntools

sudo openssl req -newkey rsa:2048 -nodes -keyout /root/MOK.key -new -x509 -sha256 -days 36500 -subj "/CN=Labyrinth Shim MOK/" -out /root/MOK.crt
sudo openssl x509 -outform DER -in /root/MOK.crt -out /root/MOK.cer
```

Copy certificate to boot partition, and sign systemd-boot and kernel binaries. We will back up the unsigned binaries just in case. Note that we copy the DER encoded `MOK.cer` to the EFI partition, not the `MOK.crt`.

```bash
sudo cp /boot/EFI/shim/grubx64.efi /root
sudo cp /boot/vmlinuz-linux /root

sudo cp /root/MOK.cer /boot/
sudo sbsign --key /root/MOK.key --cert /root/MOK.crt --output /boot/EFI/shim/grubx64.efi /boot/EFI/shim/grubx64.efi
sudo sbsign --key /root/MOK.key --cert /root/MOK.crt --output /boot/vmlinuz-linux /boot/vmlinuz-linux
```

We need to resign the binaries whenever they are updated. For the kernel, we will use the `mkinittcpio` post hook in this directory to automatically sign the kernel on upgrades:

```bash
sudo cp ./kernel-sbsign /etc/initcpio/post
sudo chmod 744 /etc/initcpio/post/kernel-sbsign
```

By default, updates to `systemd-boot` only update the installer, but do not install the updated boot loader into the EFI. If you are using the `systemd-boot-update.service` or `systemd-boot-pacman-hook` to automatically update the boot loader, you should add a pacman hook to automatically sign the boot manager after an upgrade, by following the instructions here: [Signing for Secure Boot](https://wiki.archlinux.org/title/Systemd-boot#Signing_for_Secure_Boot).

Finally, reboot and enable Secure Boot. Shim will detect that `grubx64.efi` is signed with an unknown certificate and launch MokManager. Select `Enroll key from disk` and add `MOK.cer` to `MokList`.

NOTE: You will no longer be able to boot from the Arch Linux Live USB with Secure Boot enabled. We can repack the official ISO with binaries signed by our MOK to enable this functionality again by following the instructions in [Sign the official ISO with a Machine Owner Key for shim](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#Sign_the_official_ISO_with_a_Machine_Owner_Key_for_shim).
