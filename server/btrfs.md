# show filesystems
`btrfs filesystem show`

# scrub (validate checksums)
`btrfs scrub /dev/sda1`

# view total usage of RAID volume
btrfs filesystem usage /srv/samba

# calculate disk usage of user shares
btrfs filesystem du -s /srv/samba/*

# calculate disk usage of backups
btrfs filesystem du -s /srv/backup/samba/*

