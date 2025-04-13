#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sudo $DIR/../install-pacman.sh $DIR/pacman-packages.txt
$DIR/../install-yay.sh $DIR/aur-packages.txt

# cantata requests cmake 3.0. to build with cmake 4+ we need to edit the PKGBUILD
yay --editmenu -S cantata
# select cantata to edit PKGBUILD, add the argument to the cmake command
# -DCMAKE_POLICY_VERSION_MINIMUM=3.5
