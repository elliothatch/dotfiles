#!/bin/sh
# disable auto-suspend in gdm
sudo machinectl shell gdm@ /bin/bash
export GSETTINGS_BACKEND=dconf
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
