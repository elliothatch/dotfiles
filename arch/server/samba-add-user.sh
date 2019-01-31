#!/bin/bash
useradd "$1"
smbpasswd -a "$1"
