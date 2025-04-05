#!/bin/sh
trap "exit" INT
# setup.sh is meant to be run once you have completed Arch Linux installation and are booted into the actual OS on disk for the first time as the root user
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

$DIR/core/setup.sh
$DIR/wayland/setup.sh
$DIR/icebox-client/setup.sh
$DIR/applications/setup.sh
