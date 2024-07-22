## iwd
wireless networking

### Setup

```bash
pacman -S iwd 
```

GUI client

```bash
yay -S iwgtk
```

Create `/etc/iwd/main.conf`

```
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
```

```bash
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
systemctl enable iwd --now
systemctl enable systemd-resolved --now
```

### iwctl

```bash
iwctl

device list

# if you need to power on the adapter
device wlan0 set-property Powered on
adapter wlan0 set-property Powered on

station wlan0 scan
station wlan0 get-networks
station wlan0 connect _SSID_
```

### iwgtk

Launch the tray icon. Uses StatusNotifierItem, i3bar requires compatibility layer `snixembed` (AUR).

```bash
iwgtk -i
```

## libinput
touchpad/touchscreen input

```bash
pacman -S xf86-input-libinput xorg-xinput
```

## pipewire

```bash
pacman -S pipewire pipewire-alsa pipewire-pulse pipewire-jack pipewire-audio wireplumber qpwgraph
```

```bash
pacman -S volumeicon
```

