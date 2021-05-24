#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sudo ln -svirn $DIR/usr/bin/backup-btrfs.py /usr/bin/backup-btrfs
sudo ln -svirn $DIR/usr/bin/motd.sh /usr/bin/motd
sudo ln -svirn $DIR/usr/bin/motd-update.sh /usr/bin/motd-update
sudo ln -svirn $DIR/usr/bin/diff-dirs.sh /usr/bin/diff-dirs
