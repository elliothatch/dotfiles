#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
mkdir -p $HOME/.config
mkdir -p $HOME/.local/bin

ln -svirn $DIR/.config/*[^pulse] $HOME/.config
ln -svirn $DIR/.config/pulse/default.pa $HOME/.config/pulse/default.pa
ln -svirn $DIR/.local/bin/* $HOME/.local/bin
ln -svirn $DIR/dotfiles/.* $HOME
