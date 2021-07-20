#!/bin/bash
DATE=$(date +%Y-%m-%d)
rclone sync -P --exclude 'fresh4less/Video/**' --exclude 'node_modules/' /srv/samba azure-icebox-backup:/s    ↪rv/samba
