#!/bin/sh
echo $1 | tee /sys/class/backlight/intel_backlight/brightness
