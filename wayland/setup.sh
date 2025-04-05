#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# login manager
systemctl enable greetd.service --now

sudo cp -i $DIR/etc/greetd/* /etc/greetd

sudo cp -i $DIR/usr/local/bin/* /usr/local/bin

sudo mkdir -p /usr/local/share/wayland-sessions
sudo cp -i $DIR/usr/local/share/wayland-sessions/* /usr/local/share/wayland-sessions
