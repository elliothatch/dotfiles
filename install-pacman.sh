#!/bin/sh
pacman -S $(cat "$1" | sed '/^#/ d' | tr '\n' ' ')
