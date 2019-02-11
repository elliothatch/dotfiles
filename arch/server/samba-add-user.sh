#!/bin/bash
useradd "$1"
passwd "$1"
smbpasswd -a "$1"
