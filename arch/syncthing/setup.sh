#!/bin/sh
sudo useradd -R -m -U -s /usr/bin/nologin syncthing
sudo systemctl enable syncthing@syncthing 
