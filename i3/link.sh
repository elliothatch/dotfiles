#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
ln -svirn $DIR/.config/* $HOME/.config
ln -svirn $DIR/.local/bin/* $HOME/.local/bin
