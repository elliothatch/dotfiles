#!/bin/sh
trap "exit" INT
# after setup.sh is run, log out of the root session and log in as the newly created user, then run user-setup.sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

$DIR/install-yay.sh $DIR/i3/aur-packages.txt 

# link dotfiles
# note that the link script is a little broken so you have to go back through the link directories and delete `.` and `..` dirs
$DIR/core/link.sh 
$DIR/desktop/link.sh 
$DIR/i3/link.sh 

# setup syncthing
systemctl enable syncthing@ellioth

# esp32 setup

# kicad
