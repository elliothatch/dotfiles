#!/bin/bash
DATE=$(date +%Y-%m-%d)
rclone sync -P /srv/samba azure-icebox-backup:/srv/samba
