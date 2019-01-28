#!/bin/sh
yay -S $(cat "$1" | sed '/^#/ d' | tr '\n' ' ')
