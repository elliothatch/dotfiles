#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

ln -svirn $DIR/usr/bin/backup-btrfs.py /usr/bin/backup-btrfs
ln -svirn $DIR/usr/bin/motd.sh /usr/bin/motd
ln -svirn $DIR/usr/bin/motd-update.sh /usr/bin/motd-update
ln -svirn $DIR/usr/bin/diff-dirs.sh /usr/bin/diff-dirs
