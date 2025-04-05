#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sudo $DIR/../install-pacman.sh $DIR/pacman-packages.txt
$DIR/../install-yay.sh $DIR/aur-packages.txt
